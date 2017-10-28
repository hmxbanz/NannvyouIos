//
//  NVYChangePwdVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/8/30.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import PKHUD

class NVYChangePwdVC: UIViewController {

    @IBOutlet weak var oldPwdTF: UITextField!
    
    @IBOutlet weak var newPwdTF: UITextField!
    
    @IBOutlet weak var surePwdTF: UITextField!
    
    @IBOutlet weak var sureBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "修改密码"
        
        sureBtn.layer.cornerRadius = 5.0
    }
    
    @IBAction func sureBtnAction(_ sender: UIButton) {
        
        if (oldPwdTF.text == nil || oldPwdTF.text == "") {
            HUD.flash(.label("请输入原密码"), delay: 1.0)
            return
        } else if (newPwdTF.text == nil  || newPwdTF.text == "") {
            HUD.flash(.label("请输入新密码"), delay: 1.0)
            return
        } else if (surePwdTF.text == nil  || surePwdTF.text == "") {
            HUD.flash(.label("请再次输入新密码"), delay: 1.0)
            return
        } else if (newPwdTF.text != surePwdTF.text) {
            HUD.flash(.label("两次输入新密码不一致"), delay: 1.0)
            return
        }
        
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/ChangePass",
            params: ["oldPassword" : oldPwdTF.text!,
                     "newpassword" : newPwdTF.text!])
        { (DataResponse) in
            
            let responseDict = DataResponse.result.value as! NSDictionary
            
            print("修改密码结果 = \(responseDict)")
            
            let state = responseDict["state"] as? Int
            
            if state == 1 {
                HUD.flash(.label("\(responseDict["msg"] ?? "修改密码成功")"), delay: 1.0)
                self.navigationController?.popViewController(animated: true)
            } else {
                HUD.flash(.label("\(responseDict["msg"] ?? "修改密码失败")"), delay: 1.0)
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
