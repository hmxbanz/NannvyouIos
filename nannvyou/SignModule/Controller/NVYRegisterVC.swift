//
//  NVYRegisterVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/8.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import PKHUD

class NVYRegisterVC: UIViewController {

    @IBOutlet weak var titleIcon: UIImageView!
    @IBOutlet weak var cIconTopY: NSLayoutConstraint!
    
    @IBOutlet weak var tfContainer: UIView!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var pwdTF: UITextField!
    
    @IBOutlet weak var codeTF: UITextField!
    
    @IBOutlet weak var codeBtn: UIButton!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var protocolBtn: UIButton!
    @IBOutlet weak var protocolLabel: UILabel!
    
    let tfHeight = 40.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cIconTopY.constant = UIApplication.shared.statusBarFrame.height;
        navigationItem.title = "注册"
        
        tfContainer.layer.borderColor  = UIColor.wz_colorWithHexString(hex: "#5bc0de").cgColor
        tfContainer.layer.borderWidth  = 1.0
        tfContainer.layer.cornerRadius = 5.0
        
        registerBtn.backgroundColor = UIColor.wz_colorWithHexString(hex: "#5bc0de")

        protocolLabel.isUserInteractionEnabled = true;
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(protocolLabelTap(gestuer:)));
        protocolLabel.addGestureRecognizer(tap);
        
        initViews()
        
    }
    
    func protocolLabelTap(gestuer: UITapGestureRecognizer) -> Void {
        let nextVC = TGWebViewController.init();
        nextVC.customTitle = "用户协议";
        nextVC.path = kBaseURL + "Home/GetProtocol";
        self.navigationController?.pushViewController(nextVC, animated: true);
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
        
        protocolBtn.isSelected = true
        
        registerBtn.layer.cornerRadius = 5.0
    }
    
    @IBAction func getCaptcha(_ sender: UIButton) {
        
        if (nameTF.text?.isEmpty)! {
            HUD.flash(HUDContentType.label("请输入手机号"))
            return
        }
        
        NVYSignDataTool.userGetCaptcha(phone: nameTF.text!) { (Bool) in
            
        }
    }
    
    
    @IBAction func registerAction(_ sender: UIButton) {
        
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
        
        let regModel = NVYRegRequestModel()
        regModel.userName = nameTF.text
        regModel.password = pwdTF.text
        regModel.captcha  = codeTF.text
        
        NVYSignDataTool.userRegister(regModel: regModel) { (Bool) in
            
            if Bool {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
    }
    
    @IBAction func protocolAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
