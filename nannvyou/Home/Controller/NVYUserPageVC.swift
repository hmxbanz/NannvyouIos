//
//  NVYUserPageVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/9.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class NVYUserPageVC: UIViewController {

    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    var isSelf = false
    
    var userInfoID: Int = 0
    
    var userInfoModel: NVYUserPageModel?
    
    private var scrollContainer: UIScrollView?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        screenHeight = screenFrame.height

        view.backgroundColor = UIColor.groupTableViewBackground

        scrollContainer = initScrollView()
        view.addSubview(scrollContainer!)
        
        //这里还是需要的
        self.automaticallyAdjustsScrollViewInsets = false
        
        if isSelf {
            userInfoID = NVYUserModel.getUserModel().UserInfoID
        }
        
        //不等于0，表示是其他会员的个人信息
        if userInfoID != 0 {
            NVYHomeDataTool.getUserInfo(userID: self.userInfoID) { (model) in
               
                self.userInfoModel = model as? NVYUserPageModel
                if (self.userInfoModel != nil) {
                    
                    self.initHead()
                    
                    let height: CGFloat = 280.0
                    
                    let vc = NVYUserPageInfoVC()
                    vc.userInfo = self.userInfoModel?.UserInfo
                    vc.view.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - height)
                    self.addChildViewController(vc)
                    self.scrollContainer!.addSubview(vc.view)
                    
                    let vc1 = NVYUserPageConditionVC()
                    vc1.conditionInfo = self.userInfoModel?.FriendCondition
                    vc1.view.frame = CGRect(x: self.screenWidth!, y: 0, width: self.screenWidth!, height: self.screenHeight! - height)
                    self.addChildViewController(vc1)
                    self.scrollContainer!.addSubview(vc1.view)
                                        
                    let vc2 = NVYUserDynamicVC()
                    vc2.userID = self.userInfoID
                    vc2.view.frame = CGRect(x: 2 * self.screenWidth!, y: 0, width: self.screenWidth!, height: self.screenHeight! - height)
                    self.addChildViewController(vc2)
                    self.scrollContainer!.addSubview(vc2.view)
                    
                    let layout2 = UICollectionViewFlowLayout()
                    layout2.scrollDirection = UICollectionViewScrollDirection.vertical;
                    
                    let vc3 = NVYUserPagePhotoVC(collectionViewLayout: layout2)
                    vc3.dataType = 2
                    vc3.userID = self.userInfoID
                    vc3.view.frame = CGRect(x: 3 * self.screenWidth!, y: 0, width: self.screenWidth!, height: self.screenHeight! - height)
                    self.addChildViewController(vc3)
                    self.scrollContainer!.addSubview(vc3.view)
                }
            }
        }
    }
    
    func initScrollView() -> UIScrollView {
        if (scrollContainer == nil) {
            
            scrollContainer = UIScrollView()
            scrollContainer?.frame = CGRect(x: 0, y: 280, width: screenWidth!, height: screenHeight! - 280)
            scrollContainer?.showsVerticalScrollIndicator = false
            scrollContainer?.showsHorizontalScrollIndicator = false
            scrollContainer?.bounces = false
            scrollContainer?.isPagingEnabled = true
            scrollContainer?.contentSize = CGSize(width: 4.0 * screenWidth!, height: screenHeight! - 280)
        }
        return scrollContainer!
    }
    
    func initHead()  {
        
        let userHead = Bundle.main.loadNibNamed("NVYUserPageHead", owner: nil, options: nil)?.first as? NVYUserPageHead
        userHead?.frame = CGRect(x: 0, y: 0, width: screenWidth!, height: 280)
        view.addSubview(userHead!)
        
        var userInfo = NVYUserModel()
        userInfo = Mapper<NVYUserModel>().map(JSONObject: userInfoModel?.UserInfo)!
        
        userHead?.updateHeadInfo(icon: userInfo.IconSmall ?? "", name: userInfo.NickName ?? "未填写", city: userInfo.CityName ?? "", sex: userInfo.SexName ?? "男", age: userInfo.Age, intro: userInfo.SelfDescribe ?? "未填写")
        
        if isSelf {
            userHead?.setSelfHead()
        }
        
        //举报
        userHead?.reportBlock = {
            let vc = NVYReportVC()
            vc.reportID = userInfo.UserID
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        //加入黑名单
        userHead?.blackListBlock = {
            
            let alertController = UIAlertController(title: "确认加入黑名单?", message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { (UIAlertAction) in
                
                NVYHomeDataTool.addBlackList(userID: userInfo.UserID, completion: { (Bool) in

                })

            }))
        
            self.navigationController?.present(alertController, animated: true, completion: nil)
        }
        
        //点赞
        userHead?.praiseBlcok = {
            NVYHomeDataTool.praiseUser(userID: userInfo.UserID, completion: { (Bool) in
                
            })
        }
        
        //收藏
        userHead?.collectBlcok = {
            NVYHomeDataTool.collectFriend(userID: userInfo.UserInfoID, completion: { (Bool) in
                
            })
        }
        
        //加好友
        userHead?.friendBlcok = {
            NVYHomeDataTool.addFriend(userID: userInfo.UserInfoID, completion: { (Bool) in
                
            })
        }
        
        userHead?.chatBlcok = {
            
            //先判断是否为好友
            NVYHomeDataTool.judgeFriend(userID: userInfo.UserInfoID, completion: { (result) in
                
                if result {
                    let chatVC = NVYConversationVC()
                    chatVC.conversationType = .ConversationType_PRIVATE
                    chatVC.targetId = "\(userInfo.UserInfoID)"
                    chatVC.title = userInfo.NickName
                    self.navigationController?.pushViewController(chatVC, animated: true)
                }
            })
        }
        
        
        //返回按钮
        userHead?.backBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        
        //个人信息
        userHead?.infoBlcok = {
            self.scrollContainer?.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        
        //择偶条件
        userHead?.conditionBlcok = {
            self.scrollContainer?.setContentOffset(CGPoint(x: self.screenWidth!, y: 0), animated: true)
        }
        
        //动态
        userHead?.activityBlcok = {
            self.scrollContainer?.setContentOffset(CGPoint(x: (2.0 * self.screenWidth!), y: 0), animated: true)
        }
        
        //相册
        userHead?.photoBlcok = {
            //            let scrollRect = CGRect(x: 3 * self.screenWidth!, y: 0, width: self.screenWidth!, height: self.screenHeight! - 280)
            //            self.scrollContainer?.scrollRectToVisible(scrollRect, animated: true)
            
            self.scrollContainer?.setContentOffset(CGPoint(x: (3.0 * self.screenWidth!), y: 0), animated: true)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
