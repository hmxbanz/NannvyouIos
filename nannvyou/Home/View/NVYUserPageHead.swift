//
//  NVYUserPageHead.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/9.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import Kingfisher

typealias UserPageBackBlock = () -> Void
typealias UserPageBlackListBlock    = () -> Void
typealias UserPageReportBlock    = () -> Void
typealias UserPagePraiseBlock    = () -> Void
typealias UserPageCollectBlock    = () -> Void
typealias UserPageFriendBlock    = () -> Void
typealias UserPageChatBlock    = () -> Void
typealias UserPageInfoBlock    = () -> Void
typealias UserPageConditionBlock    = () -> Void
typealias UserPageActivityBlock    = () -> Void
typealias UserPagePhotoBlock    = () -> Void


class NVYUserPageHead: UIView {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cBackTopY: NSLayoutConstraint!
    //黑名单
    @IBOutlet weak var blackListBtn: UIButton!
    
    @IBOutlet weak var reportBtn: UIButton!
    
    @IBOutlet weak var userIcon: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var introLabel: UILabel!
    
    @IBOutlet weak var praiseBtn: UIButton!
    
    @IBOutlet weak var collectBtn: UIButton!

    @IBOutlet weak var friendBtn: UIButton!
    
    @IBOutlet weak var chatBtn: UIButton!
    
    @IBOutlet weak var userInfoBtn: UIButton!
    
    @IBOutlet weak var userConditionBtn: UIButton!
    
    @IBOutlet weak var userActivityBtn: UIButton!
    
    @IBOutlet weak var userPhotoBtn: UIButton!
    
    var currentBtn: UIButton!
    
    private let btnImgs = [#imageLiteral(resourceName: "icon_thumbsup"), #imageLiteral(resourceName: "icon_add_favor"), #imageLiteral(resourceName: "icon_add_friend"), #imageLiteral(resourceName: "icon_message")]
    
    //底部滑动条
    var line: UILabel!
    
    //blocks
    var backBlock: UserPageBackBlock?
    var blackListBlock: UserPageBlackListBlock?
    var reportBlock: UserPageReportBlock?
    var praiseBlcok: UserPagePraiseBlock?
    var collectBlcok: UserPageCollectBlock?
    var friendBlcok: UserPageFriendBlock?
    var chatBlcok: UserPageChatBlock?
    var infoBlcok: UserPageInfoBlock?
    var conditionBlcok: UserPageInfoBlock?
    var activityBlcok: UserPageActivityBlock?
    var photoBlcok: UserPagePhotoBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cBackTopY.constant = UIApplication.shared.statusBarFrame.height;
        userIcon.layer.cornerRadius = userIcon.frame.size.width/2.0
        userIcon.layer.masksToBounds = true
        userIcon.layer.borderWidth = 2.0
        userIcon.layer.borderColor = UIColor.white.cgColor
        
        praiseBtn.layer.cornerRadius = 5.0
        collectBtn.layer.cornerRadius = 5.0
        friendBtn.layer.cornerRadius = 5.0
        chatBtn.layer.cornerRadius = 5.0
        
        praiseBtn.backgroundColor = UIColor.wz_colorWithHexString(hex: "#ff7da8")
        collectBtn.backgroundColor = UIColor.wz_colorWithHexString(hex: "#ff7da8")
        friendBtn.backgroundColor = UIColor.wz_colorWithHexString(hex: "#ff7da8")
        chatBtn.backgroundColor = UIColor.wz_colorWithHexString(hex: "#ff7da8")
        
        line = UILabel()
        line.frame = CGRect(x: 0, y: userInfoBtn.frame.maxY - 1, width: userInfoBtn.frame.size.width, height: 1)
        line.backgroundColor = UIColor.red
        addSubview(line)
        
        currentBtn = userInfoBtn
        
        praiseBtn.setImage(btnImgs[0], for: UIControlState.normal)
        collectBtn.setImage(btnImgs[1], for: UIControlState.normal)
        friendBtn.setImage(btnImgs[2], for: UIControlState.normal)
        chatBtn.setImage(btnImgs[3], for: UIControlState.normal)

    }
    
    
    //更新信息
    func updateHeadInfo(icon: String, name: String, city: String, sex: String, age: Int, intro: String)
    {
        let imgStr = "\(kBaseURL)\(icon)"
        let imgURL = NSURL(string: imgStr)
        let imgResource = ImageResource(downloadURL: imgURL! as URL, cacheKey: imgStr)
        userIcon?.kf.setImage(with: imgResource, placeholder: Image(named: "icon_head"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in })
        
        nameLabel.text = "\(name) \(city) \(sex) \(age)岁"
        
        introLabel.text = intro
    }
    
    
    //当是个人主页时
    func setSelfHead()
    {
        reportBtn.isHidden = true
        blackListBtn.isHidden = true
    }
    
    
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        if (backBlock != nil) {
            backBlock!()
        }
    }
    
    //button 事件处理
    //黑名单
    @IBAction func blackListBtnAction(_ sender: UIButton) {
        if (blackListBlock != nil) {
            blackListBlock!()
        }
    }
    //举报
    @IBAction func reportBtnAction(_ sender: UIButton) {
        if (reportBlock != nil) {
            reportBlock!()
        }
    }
    
    @IBAction func praiseBtnAction(_ sender: UIButton) {
        if (praiseBlcok != nil) {
            praiseBlcok!()
        }
    }
    
    @IBAction func collectBtnAction(_ sender: UIButton) {
        if (collectBlcok != nil) {
            collectBlcok!()
        }
    }
    
    @IBAction func friendBtnAction(_ sender: UIButton) {
        if (friendBlcok != nil) {
            friendBlcok!()
        }
    }
    
    @IBAction func chatBtnAction(_ sender: UIButton) {
        if (chatBlcok != nil) {
            chatBlcok!()
        }
    }
    
    @IBAction func userInfoBtnAction(_ sender: UIButton) {
        
        if currentBtn != sender {
            currentBtn = sender
            line.frame = CGRect(x: sender.frame.minX, y: userInfoBtn.frame.maxY - 1, width: userInfoBtn.frame.size.width, height: 1)
        }
        
        if (infoBlcok != nil) {
            infoBlcok!()
        }
    }
    
    @IBAction func userConditionBtnAction(_ sender: UIButton) {
        
        if currentBtn != sender {
            currentBtn = sender
            line.frame = CGRect(x: sender.frame.minX, y: userInfoBtn.frame.maxY - 1, width: userInfoBtn.frame.size.width, height: 1)
        }
        
        if (conditionBlcok != nil) {
            conditionBlcok!()
        }
    }
    
    func selectPageAt(index: Int) -> Void {
        let buttons = [userInfoBtn, userConditionBtn, userActivityBtn, userPhotoBtn];
        if index < buttons.count {
            let button = buttons[index];
            if currentBtn != button {
                currentBtn = button;
                UIView.animate(withDuration: 0.28, animations: {
                    self.line.frame = CGRect.init(x: (button?.frame.minX)!, y: (button?.frame.maxY)! - 1, width: (button?.frame.width)!, height: 1);
                });
            }
        }
    }
    
    @IBAction func userActivityBtnAction(_ sender: UIButton) {
        
        if currentBtn != sender {
            currentBtn = sender
            line.frame = CGRect(x: sender.frame.minX, y: userInfoBtn.frame.maxY - 1, width: userInfoBtn.frame.size.width, height: 1)
        }
        
        if (activityBlcok != nil) {
            activityBlcok!()
        }
    }
    
    @IBAction func userPhotoBtnAction(_ sender: UIButton) {
        
        if currentBtn != sender {
            currentBtn = sender
            line.frame = CGRect(x: sender.frame.minX, y: userInfoBtn.frame.maxY - 1, width: userInfoBtn.frame.size.width, height: 1)
        }
        
        if (photoBlcok != nil) {
            photoBlcok!()
        }
    }
}
