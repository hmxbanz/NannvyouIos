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
    
    var dataArr: Array<Any>?//<NVYHomeCellModel>?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
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
        NVYProfileDataTool.getUserAlbumByUserID(userInfoID: userID) { (dataArray) in
            if dataArray.count > 0 {
                self.dataArr = dataArray;// as? Array<NVYHomeCellModel>
                self.collectionView?.reloadData()
            }
        }
//        NVYHomeDataTool.getUserPhoto(userID: userID) { (dataArray) in
//            if dataArray.count > 0 {
//                self.dataArr = dataArray as? Array<NVYHomeCellModel>
//                self.collectionView?.reloadData()
//            }
//        }
    }
    
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if (dataArr?.count ?? 0) > 0 {
            return (dataArr?.count)!
        }
        return 1;
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? NVYHomeCell
        let arrayCount = dataArr?.count ?? 0;
        
        if arrayCount > 0 {

            if dataType == 2 {
                let model = dataArr![indexPath.row] as! NVYMyAlbumModel
                
                let imgStr = "\(kBaseURL)\(model.PhotoSmall ?? "")"
                let imgURL = NSURL(string: imgStr)
                let imgResource = ImageResource(downloadURL: imgURL! as URL, cacheKey: imgStr)
                cell?.userIcon?.kf.setImage(with: imgResource, placeholder: Image(named: "icon_head"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in
                    
                })
                
                cell?.userNameLabe.text = "\(model.PhotoInfo ?? "")"
            } else {
                let model = dataArr![indexPath.row] as! NVYHomeCellModel;
                
                let imgStr = "\(kBaseURL)\(model.IconSmall ?? "")"
                let imgURL = NSURL(string: imgStr)
                let imgResource = ImageResource(downloadURL: imgURL! as URL, cacheKey: imgStr)
                cell?.userIcon?.kf.setImage(with: imgResource, placeholder: Image(named: "icon_head"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in
                    
                })
                
                cell?.userNameLabe.text = "\(model.NickName ?? "")(\(model.CityName ?? ""))"
            }
            
            
        } else {
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "noDataCell");
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noDataCell", for: indexPath);
            var label = cell.contentView.viewWithTag(111) as! UILabel?;
            if label == nil {
                label = UILabel.init(frame: CGRect(x: 0, y: 0, width: screenWidth!, height: 120));
                label!.tag = 111;
                label?.textAlignment = .center;
                cell.contentView.addSubview(label!);
            }
            label?.text = "暂无数据";
            return cell;
//            cell?.userNameLabe.text = "暂无数据";//"未定义"
//            let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell")
//
//            cell?.textLabel?.text = "暂无数据"
//            cell?.textLabel?.textAlignment = .center
//
//            return cell!
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
            footerBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            
            let shapeLayer = CAShapeLayer.init();
            shapeLayer.frame = CGRect(x: 0, y: 8, width: UIScreen.main.bounds.size.width, height: 40 - 16);
            shapeLayer.fillColor = UIColor.clear.cgColor;
            shapeLayer.strokeColor = UIColor.wz_colorWithHexString(hex: "#FD7FA8").cgColor;
            shapeLayer.lineWidth = 2.0;
            shapeLayer.lineJoin = kCALineCapRound;
            shapeLayer.lineDashPattern = [10,5];
            shapeLayer.path = UIBezierPath.init(rect: shapeLayer.bounds).cgPath;
            footer.layer.addSublayer(shapeLayer);
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
        let arrayCount = dataArr?.count ?? 0;
        if arrayCount > 0 {
            let width  = (screenWidth! - 20)/3.0
            let height = width + 40.0
            
            return CGSize(width: width, height: height)
        }
        return CGSize(width: screenWidth!, height: 120);
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
            let model = dataArr![indexPath.row] as! NVYHomeCellModel;
            
            let vc = NVYUserPageVC()
            vc.userInfoID = model.UserInfoID
            navigationController?.pushViewController(vc, animated: true)
        } else {
            
//            let cell = collectionView.cellForItem(at: indexPath) as? NVYHomeCell
//
//            let window = UIApplication.shared.keyWindow
//            let showImgView = NVYShowBigImageView(frame: (window?.bounds)!)
//            window?.addSubview(showImgView)
//            showImgView.showBigImage(image: (cell?.userIcon.image)!)
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = UICollectionViewScrollDirection.vertical;
            let model = dataArr![indexPath.row] as! NVYMyAlbumModel;
            let vc = NVYMyAlbumDetailVC(collectionViewLayout: layout)
            vc.albumModel = model;
            vc.albumType = indexPath.row + 1
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
    {
        if dataType == 2 {
            return CGSize()
        }
        return CGSize(width: UIScreen.main.bounds.size.width, height: 40.0)
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
