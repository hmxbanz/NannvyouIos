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
import PKHUD

class NVYMainHomeVC: UIViewController, RCIMReceiveMessageDelegate{
    
    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    var isSelf = false
    
    var userInfoID: Int = 0
    
    var userInfoModel: NVYUserPageModel?
    
    var badgeLabel: UILabel?;
    let itemView =  UIView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40));
    
    private var scrollContainer: UIScrollView?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false;
        RCIM.shared().receiveMessageDelegate = self;
        updateUnreadInfo();
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
        
        let itemView = self.itemView;
        let itemImgView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 25, height: 25));
        itemImgView.center = CGPoint.init(x: itemView.frame.midX, y: itemView.frame.midY);
        itemImgView.image = UIImage.wz_changeImageTintColor(tintColor: .white, image: #imageLiteral(resourceName: "icon_msg"));
        itemView.addSubview(itemImgView);
        let badgeLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 15, height: 15));
        badgeLabel.textColor = UIColor.white;
        badgeLabel.font = UIFont.systemFont(ofSize: 13);
        badgeLabel.textAlignment = .center;
        badgeLabel.backgroundColor = .red;
        badgeLabel.layer.cornerRadius = badgeLabel.frame.height / 2.0;
        badgeLabel.layer.masksToBounds = true;
        itemView.addSubview(badgeLabel);
        self.badgeLabel = badgeLabel;
        self.updateBadgeWith(num: 9);
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(messageAction));
        itemView.addGestureRecognizer(tapGesture);
        
        let rightItem = UIBarButtonItem.init(customView: itemView);
        navigationItem.rightBarButtonItem = rightItem;
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
    
    func updateBadgeWith(num: NSInteger) -> Void {
        let numString = NSString.init(format: "%i", num);
        let font: UIFont = UIFont.systemFont(ofSize: 13);
        let attributes = [NSFontAttributeName:font];
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        var stringWidth = numString.boundingRect(with: CGSize.init(width: 100.0, height: 15.0), options: option, attributes: attributes, context: nil).width + 6;
        stringWidth = (stringWidth < 15) ? 15 : stringWidth;
        self.badgeLabel?.frame = CGRect.init(x: self.itemView.frame.maxX - stringWidth / 2.0, y: 0, width: stringWidth, height: 15);
        self.badgeLabel?.text = numString as String;
    }
    
    func messageAction() {
        let logined = NVYUserModel.isLogined();
        if logined {
            let vc = NVYChatListVC();
            self.navigationController?.pushViewController(vc, animated: true);
        }else{
            HUD.flash(.label("请先登录"), delay: 1.0);
        }
    }
    
    //MARK:RCIMReceiveMessageDelegate 融云相关方法
    //更新消息标记
    private func updateUnreadInfo(){
        let unreadCount = NVYProfileDataTool.unreadMsgTotalCount();
        badgeLabel?.isHidden = (unreadCount <= 0);
        updateBadgeWith(num: unreadCount);
    }
    
    //收到消息代理
    func onRCIMReceive(_ message: RCMessage!, left: Int32) {
        DispatchQueue.main.async { // Correct
            self.updateUnreadInfo();
        }
    }
    
    func initScrollView() -> UIScrollView {
        if (scrollContainer == nil) {
            
            scrollContainer = UIScrollView()
            scrollContainer?.frame = CGRect(x: 0, y: 200, width: screenWidth!, height: screenHeight! - 200)
            scrollContainer?.showsVerticalScrollIndicator = false
            scrollContainer?.showsHorizontalScrollIndicator = false
            scrollContainer?.bounces = false
            scrollContainer?.isPagingEnabled = true
            scrollContainer?.contentSize = CGSize(width: 3.0 * screenWidth!, height: screenHeight! - 200)
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
