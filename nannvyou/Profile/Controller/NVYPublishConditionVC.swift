//
//  NVYPublishConditionVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/27.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

//发布动态

import UIKit
import PKHUD

class NVYPublishConditionVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var contentTV: UITextView!
    
    @IBOutlet weak var picBtn: UIButton!
    
    @IBOutlet weak var publishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "发布动态"
        
        contentTV.layer.borderColor = UIColor.wz_colorWithHexString(hex: "#5bc0de").cgColor
        contentTV.layer.borderWidth = 1.0
        
        publishButton.layer.cornerRadius = 5.0
        publishButton.backgroundColor = UIColor.wz_colorWithHexString(hex: "#5bc0de")
        
    }
    
    @IBAction func picBtnAction(_ sender: UIButton) {
        
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
            
            picBtn.setImage(image, for: .normal)
            
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
        HUD.flash(.label("已取消"), delay: 1.0)
    }
    
    @IBAction func publishAction(_ sender: UIButton) {
        
//        if contentTV.text == "" {
//            HUD.flash(.labeledError(title: "请输入内容", subtitle: ""), delay: 1.0)
//            return
//        }

        NVYProfileDataTool.publishPic(content: contentTV.text, image: (picBtn.imageView?.image)!) { (result) in
            
            if result {
                HUD.flash(.label("上传成功"), delay: 1.0)
                self.navigationController?.popViewController(animated: true)
            } else {
                HUD.flash(.label("上传失败"), delay: 1.0)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
