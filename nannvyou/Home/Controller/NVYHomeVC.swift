//
//  NVYHomeVC.swift
//  nanvyou
//
//  Created by MacMin-DLC0001 on 2017/5/10.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import Kingfisher

class NVYHomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, WRCycleScrollViewDelegate {
    
    var homeCollection : UICollectionView?  = nil
    
    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    var dataArr: NSMutableArray?
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationItem.title = "主页"
        
        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        screenHeight = screenFrame.height
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "男女友", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_msg"), style: .plain, target: self, action: #selector(messageAction))
//        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        dataArr = NSMutableArray()
        
        view.addSubview(initHomeCollection())
        
        //load new data
        loadNewData(type: "New")
    }
    
    func loadNewData(type: String) {
        
        NVYHomeDataTool.getHomeUsers(type: type, pageIndex: 1, cityName: "") { (Array) in
            
            if Array.count > 0 {
                self.dataArr = (Array as! NSMutableArray)
                self.homeCollection?.reloadData()
            }
        }
    }
    
    func messageAction() {
        
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header : NVYHomeHead = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "collectionViewHeader", for: indexPath) as! NVYHomeHead
        
        header.backgroundColor = UIColor.blue
        
        let frame = header.cycleView.bounds
        let localImages = ["guide_pic_01", "guide_pic_02", "guide_pic_03"]
        let cycleScrollView = WRCycleScrollView(frame:frame, type:.LOCAL, imgs:localImages, descs:nil)
        cycleScrollView.delegate = self
        cycleScrollView.descLabelFont = UIFont.boldSystemFont(ofSize: 15)
        cycleScrollView.descLabelHeight = 50
        cycleScrollView.pageControlAliment = .CenterBottom
        header.cycleView.addSubview(cycleScrollView)
        
        header.homeNewAction = {
            self.loadNewData(type: "New")
        }
        
        header.homeHotAction = {
            self.loadNewData(type: "Hot")
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.dataArr?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //'?' == ??  '!' == ??
        let cell : NVYHomeCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? NVYHomeCell
        
//        cell?.backgroundColor = UIColor.white
        let model = dataArr?[indexPath.row] as! NVYHomeCellModel
        
        let imgStr = "\(kBaseURL)\(model.IconSmall ?? "")"
        let imgURL = NSURL(string: imgStr)
        let imgResource = ImageResource(downloadURL: imgURL! as URL, cacheKey: imgStr)
        cell?.userIcon?.kf.setImage(with: imgResource, placeholder: Image(named: "icon_head"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in
            
        })
        
        cell?.userNameLabe.text = "\(model.NickName ?? "")"
        
        return cell!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = dataArr?[indexPath.row] as! NVYHomeCellModel

        let vc = NVYUserPageVC()
        vc.userInfoID = model.UserInfoID
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width  = (screenWidth! - 40)/3.0
        let height = width + 20.0
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenWidth!, height: 200)
    }
    

    //MARK: - 这样写就是Swift的懒加载？
    func initHomeCollection() -> UICollectionView {
        if homeCollection == nil {
            
            let collectionViewLayout = UICollectionViewFlowLayout()
            collectionViewLayout.scrollDirection = UICollectionViewScrollDirection.vertical
            
            let collectionRect = CGRect(x: 0.0, y: 0.0, width: screenWidth!, height: screenHeight!)
            
            homeCollection = UICollectionView(frame: collectionRect, collectionViewLayout: collectionViewLayout)
            homeCollection?.backgroundColor = UIColor.groupTableViewBackground
            homeCollection?.delegate = self
            homeCollection?.dataSource = self
            
//            homeCollection?.register(NVYHomeCell.classForCoder(),
//                                     forCellWithReuseIdentifier: "collectionViewCell")
            homeCollection?.register(UINib.init(nibName: "NVYHomeCell", bundle: Bundle.main), forCellWithReuseIdentifier: "collectionViewCell")
            homeCollection?.register(UINib.init(nibName: "NVYHomeHead", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "collectionViewHeader")

        }
        
        return homeCollection!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
