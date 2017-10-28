//
//  NVYUserPagePhotoVC.swift
//  nanvyou
//
//  Created by MacMin-DLC0001 on 2017/7/17.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "PhotoCell"

class NVYUserPagePhotoVC: UICollectionViewController, UICollectionViewDelegateFlowLayout
{

    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    var dataType: Int = 0
    
    var userID: Int = 0
    
    var dataArr: Array<NVYHomeCellModel>?
    
    var currentPage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        screenHeight = screenFrame.height
        
        self.collectionView!.register(UINib.init(nibName: "NVYHomeCell", bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.backgroundColor = UIColor.white
        
        if dataType != 2 {
            self.collectionView!.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        }

        dataArr = Array()

        if self.dataType == 0 {
            //load new data
            self.loadNewData(type: "New")
        } else if self.dataType == 1 {
            //load new data
            self.loadNewData(type: "Hot")
        } else {
            self.fetchUserPhoto()
        }
        
    }
    
    func loadNewData(type: String) {
        
        currentPage = 1
        
        NVYHomeDataTool.getHomeUsers(type: type, pageIndex: currentPage, cityName: "") { (dataArray) in
                    
            if dataArray.count > 0 {
                self.dataArr = dataArray as? Array<NVYHomeCellModel>
                self.collectionView?.reloadData()
            }
        }
    }
    
    //获取用户相册
    func fetchUserPhoto() {
        NVYHomeDataTool.getUserPhoto(userID: userID) { (dataArray) in
            if dataArray.count > 0 {
                self.dataArr = dataArray as? Array<NVYHomeCellModel>
                self.collectionView?.reloadData()
            }
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if dataArr != nil {
            return (dataArr?.count)!
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? NVYHomeCell
        
        if (dataArr?.count)! > 0 {

            if dataType == 2 {
                let model = dataArr![indexPath.row] as! NVYUserAlbumsModel
                
                let imgStr = "\(kBaseURL)\(model.PhotoSmall ?? "")"
                let imgURL = NSURL(string: imgStr)
                let imgResource = ImageResource(downloadURL: imgURL! as URL, cacheKey: imgStr)
                cell?.userIcon?.kf.setImage(with: imgResource, placeholder: Image(named: "icon_head"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in
                    
                })
                
                cell?.userNameLabe.text = "\(model.PhotoInfo ?? "")"
            } else {
                let model = dataArr![indexPath.row]
                
                let imgStr = "\(kBaseURL)\(model.IconSmall ?? "")"
                let imgURL = NSURL(string: imgStr)
                let imgResource = ImageResource(downloadURL: imgURL! as URL, cacheKey: imgStr)
                cell?.userIcon?.kf.setImage(with: imgResource, placeholder: Image(named: "icon_head"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in
                    
                })
                
                cell?.userNameLabe.text = "\(model.NickName ?? "")(\(model.CityName ?? ""))"
            }
            
            
        } else {
            cell?.userNameLabe.text = "未定义"
        }
    
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        if dataType == 2 {
            return UICollectionReusableView()
        }
        
        if kind == UICollectionElementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
            
            let footerBtn = UIButton(frame: footer.bounds)
            footer.addSubview(footerBtn)
            
            footerBtn.addTarget(self, action: #selector(footerBtnAction), for: .touchUpInside)
            footerBtn.setTitle("请使用搜索查看更多内容", for: .normal)
            footerBtn.setTitleColor(UIColor.lightGray, for: .normal)
            
            return footer
 
        } else {
            return UICollectionReusableView()
        }
    }
    
    func footerBtnAction() {
        self.tabBarController?.selectedIndex = 0
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width  = (screenWidth! - 20)/3.0
        let height = width + 40.0
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        

        if dataType != 2 {
            let model = dataArr![indexPath.row]
            
            let vc = NVYUserPageVC()
            vc.userInfoID = model.UserInfoID
            navigationController?.pushViewController(vc, animated: true)
        } else {
            
            let cell = collectionView.cellForItem(at: indexPath) as? NVYHomeCell
            
            let window = UIApplication.shared.keyWindow
            let showImgView = NVYShowBigImageView(frame: (window?.bounds)!)
            window?.addSubview(showImgView)
            showImgView.showBigImage(image: (cell?.userIcon.image)!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
    {
        if dataType == 2 {
            return CGSize()
        }
        return CGSize(width: UIScreen.main.bounds.size.width, height: 30.0)
    }

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
