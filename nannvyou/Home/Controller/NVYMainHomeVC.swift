//
//  NVYMainHomeVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/8/14.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class NVYMainHomeVC: UIViewController {
    
    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    var isSelf = false
    
    var userInfoID: Int = 0
    
    var userInfoModel: NVYUserPageModel?
    
    private var scrollContainer: UIScrollView?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        screenHeight = screenFrame.height
        
        view.backgroundColor = UIColor.groupTableViewBackground
        
        self.automaticallyAdjustsScrollViewInsets = false

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "男女友", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_msg"), style: .plain, target: self, action: #selector(messageAction))
//        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        self.initHead()

        scrollContainer = initScrollView()
        view.addSubview(scrollContainer!)
                
        let height: CGFloat = 314.0
        
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = UICollectionViewScrollDirection.vertical;
        
        let vc2 = NVYUserPagePhotoVC(collectionViewLayout: layout1)
        vc2.view.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - height)
        self.addChildViewController(vc2)
        self.scrollContainer!.addSubview(vc2.view)
        
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = UICollectionViewScrollDirection.vertical;
        
        let vc3 = NVYUserPagePhotoVC(collectionViewLayout: layout2)
        vc3.dataType = 1
        vc3.view.frame = CGRect(x: self.screenWidth!, y: 0, width: self.screenWidth!, height: self.screenHeight! - height)
        self.addChildViewController(vc3)
        self.scrollContainer!.addSubview(vc3.view)
        
        let vc = NVYUserDynamicVC()
        vc.view.frame = CGRect(x: 2 * self.screenWidth!, y: 0, width: self.screenWidth!, height: self.screenHeight! - height)
        self.addChildViewController(vc)
        self.scrollContainer!.addSubview(vc.view)
    }
    
    func messageAction() {
        
    }
    
    func initScrollView() -> UIScrollView {
        if (scrollContainer == nil) {
            
            scrollContainer = UIScrollView()
            scrollContainer?.frame = CGRect(x: 0, y: 200, width: screenWidth!, height: screenHeight! - 200)
            scrollContainer?.showsVerticalScrollIndicator = false
            scrollContainer?.showsHorizontalScrollIndicator = false
            scrollContainer?.bounces = false
            scrollContainer?.isPagingEnabled = true
            scrollContainer?.contentSize = CGSize(width: 4.0 * screenWidth!, height: screenHeight! - 200)
        }
        return scrollContainer!
    }
    
    func initHead()  {
        
        let header : NVYMainHomeHead = Bundle.main.loadNibNamed("NVYMainHomeHead", owner: nil, options: nil)?.first as! NVYMainHomeHead
        header.frame = CGRect(x: 0, y: 0, width: screenWidth!, height: 264.0)
        view.addSubview(header)
        
        header.homeNewAction = {
            self.scrollContainer?.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        
        header.homeHotAction = {
            self.scrollContainer?.setContentOffset(CGPoint(x: self.screenWidth!, y: 0), animated: true)
        }
        
        header.homeDynamicAction = {
            self.scrollContainer?.setContentOffset(CGPoint(x: 2 * self.screenWidth!, y: 0), animated: true)

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
        
}
