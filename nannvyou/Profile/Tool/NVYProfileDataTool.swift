//
//  NVYProfileDataTool.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/30.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import PKHUD
import ObjectMapper
import Alamofire

class NVYProfileDataTool: NSObject {

    //注销登录
    func signOut(completion: @escaping (_ result: Bool) -> Void) {
        
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/Home/Logoff", params: ["userInfoId" : "\(NVYUserModel.getUserModel().UserInfoID)"]) { (DataResponse) in
            
            print("退出登录 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary
                        
            let state = responseDict?["state"] as? Int
            if (state == 1) {
                
                let userModel = NVYUserModel()
                print(userModel.UserID)
                NVYUserModel.removeUserModel()
                
                
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion(true)
            } else {
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion(false)
            }
        }
    }
    
    //获取我的个人资料
    static func getUserInfo(completion: @escaping (_ result: Bool) -> Void)
    {
        HUD.show(.systemActivity)
        
        let user = NVYUserModel.getUserModel()
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/Home/GetUser",
            params: ["userInfoId" : user.UserInfoID,
                     "queryType" : "Json"])
        { (DataResponse) in
            
            let responseDict = DataResponse.result.value as! NSDictionary
            var userPageModel = NVYUserPageModel()
            userPageModel = Mapper<NVYUserPageModel>().map(JSONObject: responseDict["UserInfo"])!
            
            var userModel = NVYUserModel()
            userModel = Mapper<NVYUserModel>().map(JSONObject: userPageModel.UserInfo)!
            
            print("获取我的个人资料 = \(userModel)")
                        
            let state = responseDict["state"] as? Int
            
            if state == 1 {
                user.IconBig = userModel.IconBig
                user.IconSmall = userModel.IconSmall
                _ = NVYUserModel.saveUserModel(user)
                
                completion(true)
                HUD.hide(animated: true)
            } else {
                HUD.flash(.labeledError(title: responseDict.object(forKey: "msg") as? String, subtitle: nil), delay: 1.5)
            }
        }
    }
    
    //获取系统对象，本地的数据
    private func getSysObj() -> NSArray {
        
        //系统对象保存位置
        var sysObjPlistPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
        
        sysObjPlistPath = sysObjPlistPath?.appending("/sysObj.plist")

        let jsonDict = NSKeyedUnarchiver.unarchiveObject(withFile: sysObjPlistPath!) as? NSDictionary
        
        let dataArr = jsonDict?["sysObj"] as! NSArray
        
        return dataArr
    }
    
    //获取学历数据
    func getEducation() -> NSArray {
        
        let sysDataArr = getSysObj()
        
        let dataArr = Mapper<NVYSysObjModel>().map(JSONObject: sysDataArr.firstObject)
        
        let data = Mapper<NVYSysObjModel>().mapArray(JSONObject: dataArr?.ChildDictionaries)
        
        return data! as NSArray
    }
    
    //获取民族数据
    func getNation() -> NSArray {
        
        let sysDataArr = getSysObj()
        
        let dataArr = Mapper<NVYSysObjModel>().map(JSONObject: sysDataArr[1])
        
        let data = Mapper<NVYSysObjModel>().mapArray(JSONObject: dataArr?.ChildDictionaries)
        
        return data! as NSArray
    }
    
    //获取职业数据
    func getJob() -> NSArray {
        
        let sysDataArr = getSysObj()
        
        let dataArr = Mapper<NVYSysObjModel>().map(JSONObject: sysDataArr[2])
        
        let data = Mapper<NVYSysObjModel>().mapArray(JSONObject: dataArr?.ChildDictionaries)
        
        return data! as NSArray
    }
    
    //获取月薪数据
    func getSalary() -> NSArray {
        
        let sysDataArr = getSysObj()
        
        let dataArr = Mapper<NVYSysObjModel>().map(JSONObject: sysDataArr[3])
        
        let data = Mapper<NVYSysObjModel>().mapArray(JSONObject: dataArr?.ChildDictionaries)
        
        return data! as NSArray
    }
    
    //获取住房情况
    func getHouse() -> NSArray {
        
        let sysDataArr = getSysObj()
        
        let dataArr = Mapper<NVYSysObjModel>().map(JSONObject: sysDataArr[4])
        
        let data = Mapper<NVYSysObjModel>().mapArray(JSONObject: dataArr?.ChildDictionaries)
        
        return data! as NSArray
    }
    
    //获取购车情况
    func getCar() -> NSArray {
        
        let sysDataArr = getSysObj()
        
        let dataArr = Mapper<NVYSysObjModel>().map(JSONObject: sysDataArr[5])
        
        let data = Mapper<NVYSysObjModel>().mapArray(JSONObject: dataArr?.ChildDictionaries)
        
        return data! as NSArray
    }

    //获取婚史情况
    func getMarry() -> NSArray {
        
        let sysDataArr = getSysObj()
        
        let dataArr = Mapper<NVYSysObjModel>().map(JSONObject: sysDataArr[6])
        
        let data = Mapper<NVYSysObjModel>().mapArray(JSONObject: dataArr?.ChildDictionaries)
        
        return data! as NSArray
    }
    
    //修改个人资料
    static func uploadSingleUserInfo(info: Any, apiName: String, completion: @escaping (_ result: Bool) -> Void) {
        
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/Update", params: ["dataType" : apiName, "data" : info]) { (DataResponse) in
            
            print("修改用户资料 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary
            
            let state = responseDict?["state"] as? Int
            if (state == 1) {
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion(true)
            } else {
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion(false)
            }
        }
    }
    
    //设置择偶条件
    static func setSingleCondition(info: Any, apiName: String, completion: @escaping (_ result: Bool) -> Void) {
        
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/FriendCondition", params: ["dataType" : apiName, "data" : info]) { (DataResponse) in
            
            print("设置择偶条件结果 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary
            
            let state = responseDict?["state"] as? Int
            if (state == 1) {
                
                
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion(true)
            } else {
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion(false)
            }
        }
    }
    
    //谁看过我
    static func fetchWhoVisitedMe(page: Int, completion: @escaping (_ result: Array<Any>) -> Void) {
        
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/GetVisitRecords", params: ["pageIndex" : page, "pageSize" : 20]) { (DataResponse) in
            
            print("谁看过我 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary
            
            let state = responseDict?["state"] as? Int
            if (state == 1) {
                
                let users = Mapper<NVYVisitModel>().mapArray(JSONObject: responseDict?["VisitRecords"])
                            
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion(users!)
            } else {
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion([])
            }
        }
    }
    
    //我看过谁
    static func fetchWhoIVisited(page: Int, completion: @escaping (_ result: Array<Any>) -> Void) {
        
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/GetVisitedByMe", params: ["pageIndex" : page, "pageSize" : 20]) { (DataResponse) in
            
            print("我看过谁 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary
            
            let state = responseDict?["state"] as? Int
            if (state == 1) {
                
                let users = Mapper<NVYVisitModel>().mapArray(JSONObject: responseDict?["VisitRecordsByMe"])

                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion(users!)
            } else {
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion([])
            }
        }
    }
    
    //我的收藏
    static func fetchMyCollection(page: Int, completion: @escaping (_ result: Array<NVYVisitModel>) -> Void) {
        
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/GetFavors", params: ["pageIndex" : page, "pageSize" : 20]) { (DataResponse) in
            
            print("我的收藏 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary
            
            let state = responseDict?["state"] as? Int
            if (state == 1) {

                let users = Mapper<NVYVisitModel>().mapArray(JSONObject: responseDict?["Favors"])
                
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion(users!)
            } else {
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion([])
            }
        }
    }
    
    //消费记录
    static func fetchMyCharge(page: Int, completion: @escaping (_ result: Array<NVYMyChargeModel>) -> Void) {
        
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/GetOrders", params: ["pageIndex" : page, "pageSize" : 20]) { (DataResponse) in
            
            print("消费记录 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary
            
            let state = responseDict?["state"] as? Int
            if (state == 1) {
                
                let users = Mapper<NVYMyChargeModel>().mapArray(JSONObject: responseDict?["Orders"])
                
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion(users!)
            } else {
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion([])
            }
        }
    }
    
    //消息列表
    static func fetchMyNote(page: Int, completion: @escaping (_ result: Array<Any>) -> Void) {
        
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/GetUserMessages", params: ["pageIndex" : page, "pageSize" : 20]) { (DataResponse) in
            
            print("消息列表 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary
            
            let state = responseDict?["state"] as? Int
            if (state == 1) {
                
                let users = Mapper<NVYMyChargeModel>().mapArray(JSONObject: responseDict?["UserMessages"])
                
                HUD.flash(.label(responseDict?["msg"] as? String), delay: 1.0)
                completion(users!)
            } else {
                HUD.flash(.label(responseDict?["msg"] as? String), delay: 1.0)
                completion([])
            }
        }
    }
    
    //获取用户相册集
    static func getUserAlbum(completion: @escaping (_ result: Array<NVYMyAlbumModel>) -> Void) {
        
        let user = NVYUserModel.getUserModel()
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/GetAlbums", params: ["objectUserInfoId" : user.UserInfoID]) { (DataResponse) in
            
            print("获取用户相册 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary
            
            let state = responseDict?["state"] as? Int
            if (state == 1) {
                
                let albums = Mapper<NVYMyAlbumModel>().mapArray(JSONObject: responseDict?["Albums"])
                
                HUD.flash(.label(responseDict?["msg"] as? String), delay: 1.0)
                completion(albums!)
            } else {
                HUD.flash(.label(responseDict?["msg"] as? String), delay: 1.0)
                completion([])
            }
        }
    }
    
    //获取用户某个相册集的相片
    static func getUserPhotos(albumID: Int, completion: @escaping (_ result: Array<NVYAlbumDetailModel>) -> Void) {
        
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/GetPhotoes", params: ["albumId" : albumID]) { (DataResponse) in
            
            print("获取用户某个相册集的相片 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary
            
            let state = responseDict?["state"] as? Int
            if (state == 1) {
                
                let albums = Mapper<NVYAlbumDetailModel>().mapArray(JSONObject: responseDict?["AlbumPhotoes"])
                
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion(albums!)
            } else {
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion([])
            }
        }
    }
    
    //获取好友列表
    static func getUserFriends(page: Int, completion: @escaping (_ result: Array<NVYFriendModel>) -> Void) {
        
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/GetFriends", params: ["pageIndex" : page, "pageSize" : 20]) { (DataResponse) in
            
            print("获取用户好友列表 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary

            let state = responseDict?["state"] as? Int
            if (state == 1) {
                
                let albums = Mapper<NVYFriendModel>().mapArray(JSONObject: responseDict?["Friends"])
                
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion(albums!)
            } else {
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion([])
            }
        }
    }

    
    //获取消息列表
    static func getUserNotes(page: Int, completion: @escaping (_ result: Array<NVYNoteModel>) -> Void) {
        
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/GetUserMessages", params: ["pageIndex" : page, "pageSize" : 20]) { (DataResponse) in
            
            print("获取用户消息列表 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary

            let state = responseDict?["state"] as? Int
            if (state == 1) {
                
                let albums = Mapper<NVYNoteModel>().mapArray(JSONObject: responseDict?["UserMessages"])
                
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion(albums!)
            } else {
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion([])
            }
        }
    }
    
    //删除好友
    static func delectFriend(userID: Int, completion: @escaping (_ result: Bool) -> Void) {
        
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/DelFriend", params: ["objectUserInfoId" : userID]) { (DataResponse) in
            
            print("获取删除好友 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary
            
            let state = responseDict?["state"] as? Int
            if (state == 1) {
                
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion(true)
            } else {
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion(false)
            }
        }
    }
    
    //同意添加好友
    static func agreeAddFriend(messageId: Int, completion: @escaping (_ result: Bool) -> Void) {

        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/AddFriendAgreed", params: ["messageId" : messageId]) { (DataResponse) in
            
            print("同意添加好友 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary
            
            let state = responseDict?["state"] as? Int
            if (state == 1) {
                
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion(true)
            } else {
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                completion(false)
            }
        }
    }
    
    //上传用户头像
    static func uploadUserIcon(image: UIImage, completion: @escaping (_ result: Bool) -> Void) {
        NVYHTTPTool.uploadPic(url: "\(kBaseURL)/User/UploadAvatar", images: [image], params: nil, completion: { (result) in
            
            print("上传头像结果 = %@",result)
            
            completion(result)
        })
    }
    
    //上传用户图片
    static func uploadUserPic(albumType: String, photoInfo: String, image: UIImage, completion: @escaping (_ result: Bool) -> Void) {
        
        NVYHTTPTool.uploadPic(url: "\(kBaseURL)/User/UploadPhoto", images: [image], params: ["albumType" : albumType, "photoInfo" : photoInfo], completion: { (result) in
            
            print("上传用户图片结果 = %@",result)

            completion(result)
            
        })
    }
    
    //发布动态
    static func publishPic(content: String, image: UIImage, completion: @escaping (_ result: Bool) -> Void) {
        
        NVYHTTPTool.uploadPic(url: "\(kBaseURL)/User/AddLifeShare", images: [image], params: ["content" : content, "continueSend" : "false"], completion: { (result) in
            
            print("发布动态结果 = %@",result)

            completion(result)
            
        })
    }
    
    //同步发送的文字消息
    static func asynMessagess(text: String, ower: Int, user: Int) {
    
        NVYHTTPTool.postMethod(hud: false, url: "\(kBaseURL)/User/AddMessage22", params: ["Content" : text, "OwnerUserInfoId" : "\(ower)", "ObjectUserInfoId" : "\(user)"]) { (DataResponse) in
            
            print("同步发送的文字消息 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary
            
            let state = responseDict?["state"] as? Int
            if (state == 1) {
                
                print(responseDict?["msg"]! ?? "")

//                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
            } else {
                print(responseDict?["msg"]! ?? "")

//                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
            }
        }
    }
    
}
