//
//  NVYFirendsDetailVC.swift
//  nannvyou
//
//  Created by Danplin on 2018/5/27.
//  Copyright © 2018年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import Kingfisher
import PKHUD;

class NVYFirendsDetailVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    public var friendModel: NVYFriendModel?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white;
        self.title = "好友详情";
        self.tableView.reloadData();
        self.tableView.tableFooterView = self.menuView;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -Actions
    func contactButtonAction(btn: UIButton) {
        //先判断是否为好友
        let targetID = self.friendModel?.ObjectUserInfoID ?? 0;
        NVYHomeDataTool.judgeFriend(userID: targetID, completion: { (result) in
            if result {
                let chatVC = NVYConversationVC(conversationType: RCConversationType.ConversationType_PRIVATE, targetId:"\(targetID)");
                chatVC?.title = self.friendModel?.ObjectNickName ?? "";
                self.navigationController?.pushViewController(chatVC!, animated: true);
            }
        })
    }
    
    func deleteFriendsActions(btn: UIButton) {
        print("删除好友");
        let friendID = self.friendModel?.ObjectUserInfoID ?? 0;
        nvy_showDelFriendAlert(friendID: friendID, fromVC: self, completion: { (result) in
            if result {
                HUD.flash(.label("删除成功"), onView: self.view, delay: 1.0, completion: { (result) in
                    self.navigationController?.popViewController(animated: true);
                });
            }else{
                HUD.flash(.label("删除好友失败"), delay: 1.0);
            }
        });
    }
    
    func addToBlackList(btn: UIButton) {
        print("加入黑名单");
        let friendID = self.friendModel?.FriendID ?? 0;
        nvy_showAddFriend2BackList(friendID: friendID, fromVC: self, completion: { (result) in
            if result {
                self.navigationController?.popViewController(animated: true);
            }
        });
    }
    
    //MARK: -Transition
    func go2UserInfoPage() {
        let vc = NVYUserPageVC()
        vc.userInfoID = self.friendModel?.ObjectUserInfoID ?? 0;
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: -UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NVYFriendCell", for: indexPath) as! NVYFriendCell
        cell.path = indexPath as NSIndexPath
        
        let model = self.friendModel;
        let imgStr = "\(kBaseURL)\(model?.ObjectIcon ?? "")"
        let imgURL = NSURL(string: imgStr)
        let imgResource = ImageResource(downloadURL: imgURL! as URL, cacheKey: imgStr)
        cell.userIcon?.kf.setImage(with: imgResource, placeholder: Image(named: "icon_head"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in
            
        })
        cell.userIcon.isUserInteractionEnabled = true;
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(go2UserInfoPage));
        cell.userIcon.addGestureRecognizer(tap);
        cell.nameLabel.text = "\(model?.ObjectNickName ?? "")";
        cell.cNameLabelY.constant = 13;
        cell.nameLabel.superview?.updateConstraintsIfNeeded();
        cell.timeLabel.isHidden = true;//"\(model?.CreateDate?.lwz_changeTime() ?? "")"
        cell.deleBtn.isHidden = true;
        
        cell.backgroundColor = .white;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    //MARK: -Accessor
    lazy var tableView: UITableView = {
        let viewH = NVY_SCREEN_HEIGHT - NVY_NavigationBarHeight();
        let frame = CGRect.init(x: 0, y: 0, width: NVY_SCREEN_WIDTH, height: viewH);
        let view = UITableView.init(frame: frame, style: UITableViewStyle.plain);
        var nib = UINib.init(nibName: "NVYFriendCell", bundle: nil);
        view.register(nib, forCellReuseIdentifier: "NVYFriendCell");
        
        view.delegate = self;
        view.dataSource = self;
        view.backgroundColor = UIColor.init(white: 0.95, alpha: 1);
        self.view.addSubview(view);
        view.snp.makeConstraints({ (make) in
            make.top.left.equalTo(0);
            make.height.equalTo(self.view);
            make.width.equalTo(self.view);
        })
        return view;
    }()
    
    lazy var menuView: UIView = {
        let buttonY: CGFloat = 30.0;
        let viewH:CGFloat = buttonY + 40 * 3 + 10 * 2;
        let frame = CGRect(x: 0, y: self.tableView.bounds.height, width: NVY_SCREEN_WIDTH, height: viewH);
        let view = UIView.init(frame: frame);
        view.backgroundColor = .clear;
        
        let color = UIColor(red: 96 / 255.0, green: 192 / 255.0, blue: 220 / 255.0, alpha: 1);
        var btnFrame = CGRect(x: 10, y: buttonY, width: view.bounds.width - 20, height: 40);
        let bgImage = UIImage.nvy_RoundImageWithColor(color: color, size: btnFrame.size, radius: 5.0);
        let button1 = UIButton.init(type: .custom);
        button1.frame = btnFrame;
        button1.setTitle("发起会话", for: .normal);
        button1.setBackgroundImage(bgImage, for: .normal);
        button1.addTarget(self, action: #selector(contactButtonAction(btn:)), for:.touchUpInside);
        view.addSubview(button1);
        
        btnFrame.origin.y = btnFrame.maxY + 10;
        let button2 = UIButton.init(type: .custom);
        button2.frame = btnFrame;
        button2.setTitle("删除好友", for: .normal);
        button2.setBackgroundImage(bgImage, for: .normal);
        button2.addTarget(self, action: #selector(deleteFriendsActions(btn:)), for:.touchUpInside);
        view.addSubview(button2);
        
        btnFrame.origin.y = btnFrame.maxY + 10;
        let button3 = UIButton.init(type: .custom);
        button3.frame = btnFrame;
        button3.setTitle("加入黑名单", for: .normal);
        button3.setBackgroundImage(bgImage, for: .normal);
        button3.addTarget(self, action: #selector(addToBlackList(btn:)), for:.touchUpInside);
        view.addSubview(button3);
        
        return view;
    }()
}
