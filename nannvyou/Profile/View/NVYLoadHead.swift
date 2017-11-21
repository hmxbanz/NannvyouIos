//
//  NVYLoadHead.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/27.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import Kingfisher

typealias SettingBlock  = () -> Void
typealias HomeBlock     = () -> Void
typealias MsgBlock      = () -> Void
typealias FriendBlock   = () -> Void
typealias ActivityBlock = () -> Void
typealias UserIconBlock = (_ userIcon: UIButton) -> Void

class NVYLoadHead: UIView {

    @IBOutlet weak var setting: UIButton!
    
    @IBOutlet weak var userIcon: UIButton!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var homeBtn: NVYVerticalButton!
    
    @IBOutlet weak var chatBtn: NVYVerticalButton!
    
    @IBOutlet weak var friendBtn: NVYVerticalButton!
    
    @IBOutlet weak var activityBtn: NVYVerticalButton!
    
    @IBOutlet weak var uploadLabel: UILabel!
    
    //block
    var headSettingAction: SettingBlock?
    var headHomeAction: HomeBlock?
    var headMsgAction: MsgBlock?
    var headFriendAction: FriendBlock?
    var headActivityAction: ActivityBlock?
    var headUserIconAction: UserIconBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userIcon.layer.cornerRadius = userIcon.frame.size.width/2.0
        userIcon.layer.masksToBounds = true
        userIcon.layer.borderColor = UIColor.white.cgColor
        userIcon.layer.borderWidth = 2.0
        
        homeBtn.titleLabel?.textAlignment = NSTextAlignment.center
        chatBtn.titleLabel?.textAlignment = NSTextAlignment.center
        friendBtn.titleLabel?.textAlignment = NSTextAlignment.center
        activityBtn.titleLabel?.textAlignment = NSTextAlignment.center

        let homeImage = UIImage.wz_changeImageTintColor(tintColor: UIColor.wz_colorWithHexString(hex: "#ff7da8"), image: #imageLiteral(resourceName: "icon_home"))
        homeBtn.setImage(homeImage, for: UIControlState.normal)
        
        let msgImage = UIImage.wz_changeImageTintColor(tintColor: UIColor.wz_colorWithHexString(hex: "#ff7da8"), image: #imageLiteral(resourceName: "icon_msg"))
        chatBtn.setImage(msgImage, for: UIControlState.normal)
        
        let frinedImg = UIImage.wz_changeImageTintColor(tintColor: UIColor.wz_colorWithHexString(hex: "#ff7da8"), image: #imageLiteral(resourceName: "icon_friend"))
        friendBtn.setImage(frinedImg, for: UIControlState.normal)
        
        let activityImg = UIImage.wz_changeImageTintColor(tintColor: UIColor.wz_colorWithHexString(hex: "#ff7da8"), image: #imageLiteral(resourceName: "icon_share"))
        activityBtn.setImage(activityImg, for: UIControlState.normal)
        
        uploadLabel.layer.cornerRadius = 10.0
        uploadLabel.layer.masksToBounds = true
        
    }
    
    //刷新界面数据
    func updateHead() {
        
        let imgStr = "\(kBaseURL)\(NVYUserModel.getUserModel().IconSmall ?? "")"
        let imgURL = NSURL(string: imgStr)
        let imgResource = ImageResource(downloadURL: imgURL! as URL, cacheKey: imgStr)
        userIcon?.kf.setImage(with: imgResource, for: .normal, placeholder: Image(named: "bg_getuser1"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in
            
        })
        
        statusLabel.text = "审核状态：\(NVYUserModel.getUserModel().CheckName ?? "待审核")    类型：\(NVYUserModel.getUserModel().RoleName ?? "")"
    }
    
    @IBAction func settingAction(_ sender: UIButton) {
        if (headSettingAction != nil) {
            headSettingAction!()
        }
    }
    
    @IBAction func userIconAction(_ sender: UIButton) {
        if (headUserIconAction != nil) {
            headUserIconAction!(sender)
        }
    }
    
    @IBAction func homeBtnAction(_ sender: NVYVerticalButton) {
        if (headHomeAction != nil) {
            headHomeAction!()
        }
    }
    
    @IBAction func chatBtnAction(_ sender: NVYVerticalButton) {
        if (headMsgAction != nil) {
            headMsgAction!()
        }
    }
    
    @IBAction func friendBtnAction(_ sender: NVYVerticalButton) {
        if (headFriendAction != nil) {
            headFriendAction!()
        }
    }
    
    @IBAction func activityBtnAction(_ sender: NVYVerticalButton) {
        if (headActivityAction != nil) {
            headActivityAction!()
        }
    }

}
