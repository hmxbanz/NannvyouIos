//
//  NVYUploadPhotoVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/28.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import PKHUD

class NVYUploadPhotoVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var introTF: UITextField!
    
    @IBOutlet weak var selectContainer: UIView!
    
    @IBOutlet weak var selectButton: UIButton!
    
    @IBOutlet weak var seleImgLabel: UILabel!
    
    @IBOutlet weak var imgButton: UIButton!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    @IBOutlet weak var imgLabel: UILabel!
    
    //图片简介
    @IBOutlet weak var imageBriefLabel: UILabel!
    //相册类型
    var albumType: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "上传图片"

        albumType = 1
        
        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        screenHeight = screenFrame.height

        selectButton.setTitle("", for: .normal)
        
        selectContainer.isHidden = true
        seleImgLabel.isHidden = true
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex;
        imageBriefLabel.isHidden = (index != 0);
        seleImgLabel.isHidden = (index != 1);
        if index == 1 {
            selectContainer.isHidden = false
            albumType = 2
        } else {
            selectContainer.isHidden = true
            albumType = 1
        }
    }
    
    @IBAction func selectBtnAction(_ sender: UIButton) {
        
        let picker = Bundle.main.loadNibNamed("NVYSingleLinePicker", owner: nil, options: nil)?.first as? NVYSingleLinePicker
        picker?.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49.0)
        self.view.addSubview(picker!)
        
        let titles: NSArray = ["身份证", "离婚证", "房产证", "车证"]
        
        picker?.pickerArr(array: titles)
        
        picker?.surePick = { (_ row: NSInteger) -> Void in
            
            self.imgLabel.text = titles[row] as? String
            
        }
    }
    
    @IBAction func imgButtonAction(_ sender: UIButton) {
        
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        actionsheet.addAction(UIAlertAction(title: "拍照", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
            
            self.takePhoto(type: 0)
        }))
        
        actionsheet.addAction(UIAlertAction(title: "从相册获取", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
            
            self.takePhoto(type: 1)
        }))
        
        actionsheet.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: { (UIAlertAction) in }))
        
        self.present(actionsheet, animated: true, completion: nil)
        
    }
    
    func takePhoto(type: Int) {
        let imagePicker = UIImagePickerController()
        imagePicker.navigationBar.tintColor = UIColor.white;
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        if type == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
            } else {
                let alert = UIAlertController(title: "您的设备不支持照相机功能", message: "", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (UIAlertAction) in
                    
                }))
                alert.show(self, sender: nil)
            }
        } else {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                imagePicker.sourceType = .photoLibrary
                imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: imagePicker.sourceType)!
            }
        }
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let type = info[UIImagePickerControllerMediaType] as! String
        
        //当选择的类型是图片
        if (type == "public.image") {
            
            
            let image = info[UIImagePickerControllerEditedImage] as! UIImage
           
            imgButton.setImage(image, for: .normal)
            
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
        HUD.flash(.label("已取消"), delay: 1.0)
    }
    
    @IBAction func uploadBtnAction(_ sender: UIButton) {
        
        if albumType == 1 {
            if introTF.text == "" {
                HUD.flash(.labeledError(title: "请输入简介", subtitle: ""), delay: 1.0)
                return
            }
        } else {
            introTF.text = ""
        }
        
        
        NVYProfileDataTool.uploadUserPic(albumType: "\(albumType)", photoInfo: introTF.text!, image: (imgButton.imageView?.image)!) { (result) in
            
            if result {
                HUD.flash(.label("上传成功"), delay: 1.0)
            } else {
                HUD.flash(.label("上传失败"), delay: 1.0)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        
    }

}
