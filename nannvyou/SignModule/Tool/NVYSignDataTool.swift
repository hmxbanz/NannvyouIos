//
//  NVYSignDataTool.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/19.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper
import PKHUD

class NVYSignDataTool: NSObject {
    
    static func userGetCaptcha(phone: String, completion: @escaping (_ result: Bool) -> Void) {
    
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/Home/GetCaptcha", params: ["cellPhone" : phone]) { (DataResponse) in
            
            print("发送验证码回调 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary
            
            let state = responseDict?["state"] as? Int
            if (state == 1) {
                HUD.flash(.labeledSuccess(title: "发送成功", subtitle: nil), delay: 1.0)
                print("发送成功 = \(state!)")
                completion(true)
            } else {
                HUD.flash(.labeledError(title: responseDict!["msg"] as? String, subtitle: nil), delay: 1.0)

                print(responseDict!["msg"]!)
                completion(false)
            }
        }
    }

    
    static func userRegister(regModel: NVYRegRequestModel, completion: @escaping (_ result: Bool) -> Void) {
        
        let parameter = regModel.toJSON()
        
        
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/Home/Register", params: parameter) { (DataResponse) in
            
            print("注册回调 = \(DataResponse)")

            let responseDict = DataResponse.result.value as? NSDictionary

            let state = responseDict?["state"] as? Int
            if (state == 1) {
                HUD.flash(.labeledSuccess(title: responseDict?["msg"] as? String, subtitle: nil), delay: 1.0)

                print(state!)
                completion(true)
            } else {
                HUD.flash(.labeledError(title: responseDict!["msg"] as? String, subtitle: nil), delay: 1.0)

                print(responseDict!["msg"]!)
                completion(false)
            }
        }
    }
    
    
    static func userLogin(loginModel: NVYLoginRequestModel, completion: @escaping (_ result: Bool) -> Void) {
        
        let parameter = loginModel.toJSON()

        NVYHTTPTool.postMethod(url: "\(kBaseURL)/Home/Login", params: parameter) { (DataResponse) in
            
            print("登录回调 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary
            
            let state = responseDict?["state"] as? Int
            if (state == 1) {
                
                HUD.flash(.labeledSuccess(title: responseDict?["msg"] as? String, subtitle: nil), delay: 1.0)

                var userModel = NVYUserModel()
                userModel = Mapper<NVYUserModel>().map(JSONObject: responseDict?["UserInfo"])!
                
                _ = NVYUserModel.saveUserModel(userModel)
                
                //绑定极光推送别名
                JPUSHService.setAlias("\(userModel.UserInfoID)", completion: { (iResCode, iAlias, seq) in
                    
                }, seq: userModel.UserInfoID)
                
                //登录融云
                RCIM.shared().connect(withToken: userModel.RongCloudToken, success: { (String) in
                    print("融云登录成功")
                }, error: { (RCConnectErrorCode) in
                    print("融云登录失败")
                }, tokenIncorrect: {
                    print("融云登录失败")
                })
                
                let notificationName = Notification.Name(rawValue: kNVYUserDidLogin);
                NotificationCenter.default.post(name: notificationName, object: nil);
                
                print(userModel)
                print(state!)
                completion(true)
            } else {
                HUD.flash(.labeledError(title: responseDict!["msg"] as? String, subtitle: nil), delay: 1.0)

                print(responseDict!["msg"]!)
                completion(false)
            }
        }
    }
    
    static func userForget(forgetModel: NVYForgetRequestModel, completion: @escaping (_ result: Bool) -> Void) {
        
        let parameter = forgetModel.toJSON()
        
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/Home/FindPassword", params: parameter) { (DataResponse) in
            
            print("忘记密码回调 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary
            
            let state = responseDict?["state"] as? Int
            if (state == 1) {
                HUD.flash(.labeledSuccess(title: responseDict?["msg"] as? String, subtitle: nil), delay: 1.0)

                print(state!)
                completion(true)
            } else {
                HUD.flash(.labeledError(title: responseDict!["msg"] as? String, subtitle: nil), delay: 1.0)
                print(responseDict!["msg"]!)
                completion(false)
            }
        }
    }
}
