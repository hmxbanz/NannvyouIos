//
//  NVYHomeDataTool.swift
//  nanvyou
//
//  Created by MacMin-DLC0001 on 2017/8/3.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper
import PKHUD

class NVYHomeDataTool: NSObject {

    //获取首页数据
    static func getHomeUsers(type: String, pageIndex: Int, cityName: String, completion: @escaping (_ models: Array<Any>) -> Void)
    {
        HUD.show(.systemActivity)
        
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/Home/GetMembers",
                              params: ["type" : type,
                                       "cityName" : "汕头市",
                                       "pageIndex" : "\(pageIndex)",
                                       "pageSize" : "18"]) { (DataResponse) in
            
                                        let responseDict = DataResponse.result.value as! NSDictionary

                                        print("获取首页最新或者最热数据 = \(responseDict)")

                                        let models = Mapper<NVYHomeCellModel>().mapArray(JSONArray: responseDict.object(forKey: "UserList") as! [[String : Any]])
                                        
                                        if models.count > 0 {
                                            completion(models)
                                            HUD.hide(animated: true)
                                        } else {
                                            HUD.flash(.labeledError(title: responseDict.object(forKey: "msg") as? String, subtitle: nil), delay: 1.5)
                                        }
                                        
        }
    }
    
    //首页动态
    static func getHomeDynamicData(pageIndex: Int, completion: @escaping (_ models: Array<NVYHomeCellModel>) -> Void)
    {
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/Home/GetDynamics",
            params: ["pageIndex" : "\(pageIndex)",
                     "pageSize" : "18"]) { (DataResponse) in
                        
                        let responseDict = DataResponse.result.value as! NSDictionary
                        
                        print("获取首页动态数据 = \(responseDict)")
                        
                        let models = Mapper<NVYHomeCellModel>().mapArray(JSONArray: responseDict.object(forKey: "LifeShares") as! [[String : Any]])
                        
                        if models.count > 0 {
                            completion(models)
                        } else {
                            HUD.flash(.labeledError(title: responseDict.object(forKey: "msg") as? String, subtitle: nil), delay: 1.5)
                            completion([])
                        }
        }
    }
    
    //获取某个会员的动态
    static func getUserDynamicData(userID: Int, pageIndex: Int, completion: @escaping (_ models: Array<NVYHomeCellModel>) -> Void)
    {
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/Home/GetDynamics",
            params: ["pageIndex" : "\(pageIndex)",
                     "pageSize" : "18",
                     "userInfoId" : "\(userID)"]) { (DataResponse) in
                    
                    let responseDict = DataResponse.result.value as! NSDictionary
                    
                    print("获取某个会员的动态数据 = \(responseDict)")
                    
                    let models = Mapper<NVYHomeCellModel>().mapArray(JSONArray: responseDict.object(forKey: "LifeShares") as! [[String : Any]])
                    
                    if models.count > 0 {
                        completion(models)
                    } else {
//                        HUD.flash(.labeledError(title: responseDict.object(forKey: "msg") as? String, subtitle: nil), delay: 1.5)
                        print(responseDict.object(forKey: "msg") ?? "")
                        completion([])
                    }
        }
    }
    
    //获取某个会员的数据
    static func getUserInfo(userID: Int, completion: @escaping (_ models: Any) -> Void)
    {
        HUD.show(.systemActivity)

        NVYHTTPTool.postMethod(url: "\(kBaseURL)/Home/GetUser",
            params: ["userInfoId" : userID,
                     "queryType" : "Json"])
        { (DataResponse) in
                        
            let responseDict = DataResponse.result.value as! NSDictionary
            var userPageModel = NVYUserPageModel()
            userPageModel = Mapper<NVYUserPageModel>().map(JSONObject: responseDict["UserInfo"])!
            
            print("获取某个会员的数据 = \(userPageModel)")
            
            let state = responseDict["state"] as? Int

            if state == 1 {
                completion(userPageModel)
                HUD.hide(animated: true)
            } else {
                HUD.flash(.labeledError(title: responseDict.object(forKey: "msg") as? String, subtitle: nil), delay: 1.5)
            }
        }
    }
    
    static func getADLists(completion: @escaping (_ lists: [NSDictionary]?) -> Void){
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/Home/GetADs", params: nil) { (DataResponse) in
            let responseDict = DataResponse.result.value as! NSDictionary;
            let state = responseDict["state"] as? Int
            if state == 1 {
                let list = responseDict.object(forKey: "ADs") as? [NSDictionary];
                print(list ?? "没有广告图");
                completion(list);
            }else{
                print("获取广告图失败");
            }
        };
    }
    
    //取用户相册
    static func getUserPhoto(userID: Int, completion: @escaping (_ models: Array<Any>) -> Void)
    {
        HUD.show(.systemActivity)

        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/GetPhotoes",
            params: ["userInfoId" : userID])
        { (DataResponse) in
            
            print("取用户相册的数据 = \(DataResponse)")

            let responseDict = DataResponse.result.value as! NSDictionary
            
            let models = Mapper<NVYUserAlbumsModel>().mapArray(JSONObject: responseDict["AlbumPhotoes"])
            
            let state = responseDict["state"] as? Int
            
            if state == 1 {
                completion(models!)
                HUD.hide(animated: true)
            } else {
//                HUD.flash(.labeledError(title: responseDict.object(forKey: "msg") as? String, subtitle: nil), delay: 1.5)
            }
        }
    }
    
    
    //会员点赞
    static func praiseUser(userID: Int, completion: @escaping (_ result: Bool) -> Void)
    {
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/AddThumbsUp",
            params: ["objectUserInfoId" : userID])
        { (DataResponse) in
            //报错404
            let responseDict = DataResponse.result.value as! NSDictionary
            
            print("点赞某个会员 = \(responseDict)")
            
            let state = responseDict["state"] as? Int
            
            if state == 1 {
                completion(true)
                HUD.flash(.label("\(responseDict["msg"] ?? "点赞成功")"), delay: 1.0)
            } else {
                completion(false)
                HUD.flash(.label("\(responseDict["msg"] ?? "点赞失败")"), delay: 1.0)
            }
        }
    }
    
    //收藏好友
    static func collectFriend(userID: Int, completion: @escaping (_ result: Bool) -> Void)
    {
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/AddFavor",
            params: ["objectUserInfoId" : userID])
        { (DataResponse) in
            
            let responseDict = DataResponse.result.value as! NSDictionary
            
            print("收藏某个会员 = \(responseDict)")
            
            let state = responseDict["state"] as? Int
            
            if state == 1 {
                completion(true)
                HUD.flash(.label("\(responseDict["msg"] ?? "收藏成功")"), delay: 1.0)
            } else {
                completion(false)
                HUD.flash(.label("\(responseDict["msg"] ?? "收藏失败")"), delay: 1.0)
            }
        }
    }
    
    //加好友
    static func addFriend(userID: Int, completion: @escaping (_ result: Bool) -> Void)
    {
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/AddFriend",
            params: ["objectUserInfoId" : userID])
        { (DataResponse) in
            
            let responseDict = DataResponse.result.value as! NSDictionary
            
            print("添加某个会员为好友 = \(responseDict)")
            
            let state = responseDict["state"] as? Int
            
            if state == 1 {
                completion(true)
                HUD.flash(.label("\(responseDict["msg"] ?? "添加成功")"), delay: 1.0)
            } else {
                completion(false)
                HUD.flash(.label("\(responseDict["msg"] ?? "添加失败")"), delay: 1.0)
            }
        }
    }
    
    //判断是否好友
    static func judgeFriend(userID: Int, completion: @escaping (_ result: Bool) -> Void)
    {
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/AddSession",
            params: ["objectUserInfoId" : userID])
        { (DataResponse) in
            
            let responseDict = DataResponse.result.value as! NSDictionary
            
            print("判断是否好友 = \(responseDict)")
            
            let state = responseDict["state"] as? Int
            
            if state == 1 {
                completion(true)
            } else {
                completion(false)
                HUD.flash(.label("不是好友不能聊天"), delay: 1.0)
            }
        }
    }
    
    
    //黑名单
    static func addBlackList(userID: Int, completion: @escaping (_ result: Bool) -> Void)
    {
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/Home/AddBlackList",
            params: ["objectUserInfoID" : "\(userID)"])
        { (DataResponse) in
            
            let responseDict = DataResponse.result.value as! NSDictionary
            
            print("添加黑名单 = \(responseDict)")
            
            let state = responseDict["state"] as? Int
            
            if state == 1 {
                completion(true)
                HUD.flash(.label("\(responseDict["msg"] ?? "添加成功")"), delay: 1.0)
            } else {
                completion(false)
                HUD.flash(.label("\(responseDict["msg"] ?? "添加失败")"), delay: 1.0)
            }
        }
    }
    
    
}
