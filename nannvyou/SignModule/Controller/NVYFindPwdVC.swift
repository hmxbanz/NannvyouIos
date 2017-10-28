//
//  NVYFindPwdVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/12.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import PKHUD

class NVYFindPwdVC: UIViewController {

    @IBOutlet weak var titleIcon: UIImageView!
    
    @IBOutlet weak var tfContainer: UIView!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var pwdTF: UITextField!
    
    @IBOutlet weak var codeTF: UITextField!
    
    @IBOutlet weak var codeBtn: UIButton!
    
    @IBOutlet weak var sureButton: UIButton!
    
    let tfHeight = 40.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "找回密码"
        
        tfContainer.layer.borderColor  = UIColor.wz_colorWithHexString(hex: "#5bc0de").cgColor
        tfContainer.layer.borderWidth  = 1.0
        tfContainer.layer.cornerRadius = 5.0
        
        sureButton.backgroundColor = UIColor.wz_colorWithHexString(hex: "#5bc0de")

        initViews()
        
    }
    
    func initViews() {
        let nameLeftView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: tfHeight))
        nameLeftView.image = #imageLiteral(resourceName: "icon_cellphone")
        nameLeftView.contentMode = UIViewContentMode.scaleAspectFit
        nameTF.leftView = nameLeftView
        nameTF.leftViewMode = UITextFieldViewMode.always
        
        let pwsLeftView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: tfHeight))
        pwsLeftView.image = #imageLiteral(resourceName: "icon_pass")
        pwsLeftView.contentMode = UIViewContentMode.scaleAspectFit
        pwdTF.leftView = pwsLeftView
        pwdTF.leftViewMode = UITextFieldViewMode.always
        
        let codeLeftView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: tfHeight))
        codeLeftView.image  = #imageLiteral(resourceName: "icon_captcha")
        codeLeftView.contentMode = UIViewContentMode.scaleAspectFit
        codeTF.leftView = codeLeftView
        codeTF.leftViewMode = UITextFieldViewMode.always
        
        codeBtn.layer.cornerRadius = 5.0
        
        sureButton.layer.cornerRadius = 5.0
    }
    
    @IBAction func getCaptcha(_ sender: UIButton) {
        
        if (nameTF.text?.isEmpty)! {
            HUD.flash(HUDContentType.label("请输入手机号"))
            return
        }
        
        NVYSignDataTool.userGetCaptcha(phone: nameTF.text!) { (Bool) in
            
        }
    }
    
    
    @IBAction func sureBtnAction(_ sender: UIButton) {
        
        if (nameTF.text?.isEmpty)! {
            HUD.flash(HUDContentType.label("请输入手机号"))
            return
        } else if (pwdTF.text?.isEmpty)! {
            HUD.flash(HUDContentType.label("请输入密码"))
            return
        } else if (codeTF.text?.isEmpty)! {
            HUD.flash(HUDContentType.label("请输入验证码"))
            return
        }
        
        let forget = NVYForgetRequestModel()
        forget.userName = nameTF.text
        forget.password = pwdTF.text
        forget.captcha = codeTF.text
        
        NVYSignDataTool.userForget(forgetModel: forget) { (Bool) in
            if Bool {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
