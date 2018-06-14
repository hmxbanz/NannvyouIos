//
//  NVYSettingVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/26.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import PKHUD

class NVYSettingVC: UITableViewController {
    
    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    var userSetting: NSDictionary?

    override func viewDidLoad() {
        super.viewDidLoad()

        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        screenHeight = screenFrame.height
        
        view.backgroundColor = UIColor.groupTableViewBackground

        navigationItem.title = "设置"

        var frame = view.frame
        frame.size.height = 150.0
        tableView.frame = frame
        
        tableView.rowHeight = 50.0
        tableView.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.001))
        tableView.register(UINib.init(nibName: "NVYSwitchCell", bundle: Bundle.main), forCellReuseIdentifier: "NVYSwitchCell")
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "normalCell")
        
        let signOutBtn = UIButton(frame: CGRect(x: 20.0, y: 180.0, width: screenWidth! - 40.0, height: 40.0))
        signOutBtn.layer.cornerRadius = 5.0
        view.addSubview(signOutBtn)
        signOutBtn.backgroundColor = UIColor.wz_colorWithHexString(hex: "#5bc0de")
        signOutBtn.setTitle("注销登录", for: .normal)
        signOutBtn.addTarget(self, action: #selector(signOutAction), for: .touchUpInside)
        
        let info = Bundle.main.infoDictionary!;
        let version = "版本号：\(info["CFBundleShortVersionString"] ?? "")";
        let versionLabel = UILabel.init(frame: CGRect(x: 0, y: signOutBtn.frame.maxY + 20, width: NVY_SCREEN_WIDTH, height: 21));
        versionLabel.textColor = UIColor.darkGray;
        versionLabel.textAlignment = .center;
        versionLabel.font = UIFont.systemFont(ofSize: 15);
        versionLabel.text = version;
        view.addSubview(versionLabel);
    }
    
    func signOutAction() {
        
        let profileDataTool = NVYProfileDataTool()
        
        profileDataTool.signOut { (Bool) in
            
            if Bool {
                let user = NVYUserModel.getUserModel()
                //移除极光推送别名
                JPUSHService.deleteAlias({ (iResCode, iAlias, seq) in
                    
                }, seq: user.UserInfoID)
                
                RCIM().disconnect(false)
                NVYUserModel.removeLoginUser();
                self.tabBarController?.selectedIndex = 1;
                self.tabBarController?.tabBar.isHidden = false;
                self.navigationController?.popViewController(animated: false)
            }
        }
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NVYSwitchCell", for: indexPath) as? NVYSwitchCell
            cell?.selectionStyle = .none
            cell?.path = indexPath as NSIndexPath
            cell?.cellTitleLabel.textColor = UIColor.wz_colorWithHexString(hex: "#ff7da8")
            if (indexPath.row == 0) {
                cell?.cellTitleLabel.text = "关闭资料"
                
                let status = UserDefaults.standard.value(forKey: "UserInfoStatus") as? Bool
                cell?.cellSwitch.isOn = status ?? false
                
            } else {
                cell?.cellTitleLabel.text = "相册保密"
            }
            
            cell?.switchBlock = { (path, status) in
                
                if (path.row == 0) {
                    NVYHTTPTool.postMethod(url: "\(kBaseURL)/User/Config",
                        params: ["dataType" : "UserInfoStatus",
                                 "data" : status])
                    { (DataResponse) in
                        
                        let responseDict = DataResponse.result.value as! NSDictionary
                        
                        print("设置个人资料状态 = \(responseDict)")
                        
                        let state = responseDict["state"] as? Int
                        
                        if state == 1 {
                            HUD.flash(.label("\(responseDict["msg"] ?? "设置成功")"), delay: 1.0)
                            UserDefaults.standard.set(status, forKey: "UserInfoStatus")
                        } else {
                            HUD.flash(.label("\(responseDict["msg"] ?? "设置失败")"), delay: 1.0)
                        }
                    }
                    
                } else {
                    
                }
            }
            
            return cell!
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath)
            cell.selectionStyle = .none
            
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "修改密码"
            cell.textLabel?.textColor = UIColor.wz_colorWithHexString(hex: "#ff7da8")

            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row < 1 {
            return
        }
        
        let changePwdVC = NVYChangePwdVC()
        self.navigationController?.pushViewController(changePwdVC, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
