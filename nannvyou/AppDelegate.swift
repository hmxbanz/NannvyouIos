
//
//  AppDelegate.swift
//  nanvyou
//
//  Created by MacMin-DLC0001 on 2017/4/28.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
//一个JSON转模型的第三方框架
import ObjectMapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, JPUSHRegisterDelegate, RCIMUserInfoDataSource {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window?.makeKeyAndVisible()
        
        let appStart = UserDefaults.standard.bool(forKey: "AppStart")
        if appStart {
            
            let tabBarController = NVYTabBarController()
            self.window!.rootViewController = tabBarController
            tabBarController.selectedIndex = 1
        } else {
        
            let wellCome = NVYWellcomeVC()
            self.window!.rootViewController = wellCome
        }
        
        //获取系统对象并保存
        fetchAndSaveSysObj()
        
        //极光推送初始化
        initJpush(launchOptions: launchOptions)
        
        //融云初始化
        RCIM.shared().initWithAppKey("sfci50a7cc3li")
        let user = NVYUserModel.getUserModel()
        if user.RongCloudToken != nil {
            RCIM.shared().connect(withToken: user.RongCloudToken, success: { (userID) in
                print("融云登录成功 用户ID = \(userID ?? "")")
                RCIM.shared().userInfoDataSource = self
            }, error: { (RCConnectErrorCode) in
                print("融云登录失败")
            }, tokenIncorrect: {
                print("融云登录失败")
            })
        }
        
        return true
    }
    
    //融云获取用户的信息
    func getUserInfo(withUserId userId: String!, completion: ((RCUserInfo?) -> Void)!) {
        
        NVYHomeDataTool.getUserInfo(userID: Int(userId)!) { (userModel) in
            let userPageModel = userModel as? NVYUserPageModel
            let userDict = userPageModel?.UserInfo
            var user = NVYUserModel()
            user = Mapper<NVYUserModel>().map(JSONObject: userDict)!
            
            let userInfo = RCUserInfo()
            userInfo.userId = "\(user.UserInfoID)"
            userInfo.name = user.NickName
            userInfo.portraitUri = "\(kBaseURL)\(user.IconSmall ?? "")"
            
            completion(userInfo)
        }
    }
    
    //获取系统对象并保存
    func fetchAndSaveSysObj() {
        let url = kBaseURL.appending("/Nny/GetSysObj")
        
        NVYHTTPTool.getMethod(hud: false, url: url, params: nil) { (DataResponse) in
            
            //系统对象保存位置
            var sysObjPlistPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
            
            sysObjPlistPath = sysObjPlistPath?.appending("/sysObj.plist")
            
            let jsonDict = DataResponse.result.value as! NSDictionary
            
            let state = jsonDict["state"] as? Int

            if (state == 1) {
                
//                let dataArr = jsonDict["sysObj"] as! NSArray
//                
//                let result = dataArr.write(toFile: sysObjPlistPath!, atomically: true)
//                print(result)
                let result = NSKeyedArchiver.archiveRootObject(jsonDict, toFile: sysObjPlistPath!)
                        
                print(result)
            }
        }
    }
    
    func initJpush(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        //Required
        //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
        let entity = JPUSHRegisterEntity()
        entity.types = 8
        
        //        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //            // 可以添加自定义categories
        //            // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        //            // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
        //        }
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        
        // Required
        // init Push
        // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
        // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
        JPUSHService.setup(withOption: launchOptions, appKey: "135a1243265761a9a5a0d28a", channel: "App Store", apsForProduction: true)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        /// Required - 注册 DeviceToken
        JPUSHService.registerDeviceToken(deviceToken)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        //Optional
        print("did Fail To Register For Remote Notifications With Error: %@", error);
    }
    
    //MARK: - JPUSHRegisterDelegate
    // iOS 10 Support
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(.newData)
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        
        let userInfo = notification.request.content.userInfo;
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo);
        }
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
        // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        
        let userInfo = response.notification.request.content.userInfo;
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo);
        }
        completionHandler();
//        // 应用打开的时候收到推送消息
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName_ReceivePush), object: nil, userInfo: userInfo)
    }
    
    // 接收到推送实现的方法
    func receivePush(_ userInfo : Dictionary<String,Any>) {
        // 角标变0
        UIApplication.shared.applicationIconBadgeNumber = 0;
        // 剩下的根据需要自定义
//        self.tabBarVC?.selectedIndex = 0;
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName_ReceivePush), object: NotificationObject_Sueecess, userInfo: userInfo)
    }
    
}

