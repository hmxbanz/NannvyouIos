//
//  NVYLoginVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/7.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import PKHUD

typealias LoginSuccessBlock = () -> Void

class NVYLoginVC: UIViewController {

    @IBOutlet weak var titleIcon: UIImageView!
    
    @IBOutlet weak var tfContainer: UIView!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var pwdTF: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var protocolBtn: UIButton!
    
    @IBOutlet weak var forgetBtn: UIButton!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var wxBtn: UIButton!
    
    let tfHeight = 40.0
    
    var presentMode = false;
    
    
    var loginSuccess: LoginBlock?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "登录"
        
        tfContainer.layer.borderColor  = UIColor.wz_colorWithHexString(hex: "#5bc0de").cgColor
        tfContainer.layer.borderWidth  = 1.0
        tfContainer.layer.cornerRadius = 5.0
        
        loginBtn.backgroundColor = UIColor.wz_colorWithHexString(hex: "#5bc0de")
        
        initTF()
        
        initBtn()
        
        configNavBackButtonIfNeed();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
    }
    
    func configNavBackButtonIfNeed() {
        if presentMode {
            let backIcon = UIImage.init(named: "arrow_left");
            let customView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44));
            let actionBtn = UIButton.init(type: UIButtonType.custom);
            actionBtn.frame = CGRect.init(x: 0, y: 0, width: 25, height: 25);
            actionBtn.setImage(backIcon, for: UIControlState.normal);
            actionBtn.addTarget(self, action: #selector(backNavigationButtonPressed(btn:)), for: .touchUpInside);
            actionBtn.center = CGPoint.init(x: 11, y: 22);
            customView.addSubview(actionBtn);
            let backItem = UIBarButtonItem.init(customView: customView);//UIBarButtonItem.init(image: backIcon, style: UIBarButtonItemStyle.plain, target: self, action: #selector(backNavigationButtonPressed(btn:)));
            self.navigationItem.leftBarButtonItem = backItem;
        }
    }
    
    func backNavigationButtonPressed(btn:UIButton){
        self.navigationController?.dismiss(animated: true, completion: nil);
    }
    
    func initTF() {
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
        
        loginBtn.layer.cornerRadius = 5.0

    }
    
    func initBtn() {
        registerBtn.titleLabel?.textAlignment = NSTextAlignment.center
        wxBtn.titleLabel?.textAlignment = NSTextAlignment.center
        wxBtn.isHidden = true
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        if (nameTF.text?.isEmpty)! {
            HUD.flash(HUDContentType.label("请输入手机号"))
            return
        } else if (pwdTF.text?.isEmpty)! {
            HUD.flash(HUDContentType.label("请输入密码"))
            return
        }
        
        let loginModel = NVYLoginRequestModel()
        loginModel.userName = nameTF.text
        loginModel.password = pwdTF.text
        
        NVYSignDataTool.userLogin(loginModel: loginModel) { (Bool) in
            
            if Bool {
                if (self.loginSuccess != nil) {
                    self.loginSuccess!()
                }
                NVYUserModel.saveLoginUser(userName: loginModel.userName, password: loginModel.password);
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func forgetAction(_ sender: UIButton) {
        
        let findPwdVC = NVYFindPwdVC()
        navigationController?.pushViewController(findPwdVC, animated: true)
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        let register = NVYRegisterVC()
        navigationController?.pushViewController(register, animated: true)
        
    }
    
    @IBAction func wxAction(_ sender: UIButton) {
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
