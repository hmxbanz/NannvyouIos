//
//  NVYMyFriendVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/25.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import Kingfisher
import PKHUD
import ESPullToRefresh

class NVYMyFriendVC: UITableViewController {

    var listArr: Array<NVYFriendModel>?

    var currentPage: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        listArr = Array()

        view.backgroundColor = UIColor.groupTableViewBackground
        
        navigationItem.title = "我的好友"
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "normalCell")
        tableView.register(UINib.init(nibName: "NVYFriendCell", bundle: Bundle.main), forCellReuseIdentifier: "NVYFriendCell")
        
        var header: ESRefreshProtocol & ESRefreshAnimatorProtocol
        var footer: ESRefreshProtocol & ESRefreshAnimatorProtocol
        
        header = ESRefreshHeaderAnimator.init(frame: CGRect.zero)
        footer = ESRefreshFooterAnimator.init(frame: CGRect.zero)
        
        self.tableView?.es.addPullToRefresh(animator: header) { [unowned self] in
            self.refresh()
        }
        
        self.tableView?.es.addInfiniteScrolling(animator: footer) { [unowned self] in
            self.loadMore()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.refresh()
    }
    
    private func refresh() {
        self.currentPage = 1
        NVYProfileDataTool.getUserFriends(page: self.currentPage) { (friends) in
            
            if friends.count > 0 {
                self.listArr = friends
                
                self.tableView.reloadData()
            }
            
            /// Stop refresh when your job finished, it will reset refresh footer if completion is true
            self.tableView.es.stopPullToRefresh(ignoreDate: true)
            /// Set ignore footer or not
            self.tableView.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
        }
    }
    
    private func loadMore() {
        self.currentPage += 1
        NVYProfileDataTool.getUserFriends(page: self.currentPage) { (friends) in
            
            if friends.count > 0 {
                for model in friends {
                    self.listArr?.append(model)
                }
                self.tableView.reloadData()
            } else {
                self.currentPage -= 1
                HUD.flash(.labeledError(title: "无更多数据", subtitle: ""), delay: 1.5)
            }
            
            /// 如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
            self.tableView.es.stopLoadingMore()
            
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        var count = listArr?.count ?? 0;
        if count == 0 {
            count = 1;
        }
        return count;
//        return (listArr?.count)!
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 60.0
        }
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell")
            
            cell?.textLabel?.text = "新的朋友"
            cell?.textLabel?.textColor = .wz_colorWithHexString(hex: "#5bc0de")
            cell?.accessoryType = .disclosureIndicator
            
            return cell!
        } else {
            let count = listArr?.count ?? 0;
            if count > 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NVYFriendCell", for: indexPath) as! NVYFriendCell
                cell.path = indexPath as NSIndexPath
                
                if (listArr?.count)! > 0 {
                    let model = listArr![indexPath.row]
                    
                    let imgStr = "\(kBaseURL)\(model.ObjectIcon ?? "")"
                    let imgURL = NSURL(string: imgStr)
                    let imgResource = ImageResource(downloadURL: imgURL! as URL, cacheKey: imgStr)
                    cell.userIcon?.kf.setImage(with: imgResource, placeholder: Image(named: "icon_head"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in
                        
                    })
                    
                    cell.nameLabel.text = "\(model.ObjectNickName ?? "")"
                    cell.timeLabel.text = "\(model.CreateDate?.lwz_changeTime() ?? "")"
                    
                    cell.cellDeleBlock = { (index) -> Void in
                        let model = self.listArr![index.row];
                        nvy_showDelFriendAlert(friendID: model.ObjectUserInfoID, fromVC: self, completion: { (result) in
                            self.refresh();
                        });
                        //                    let alertController = UIAlertController(title: "确认加入黑名单?", message: nil, preferredStyle: .alert)
                        //                    alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
                        //                    alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { (UIAlertAction) in
                        //
                        //                        let model = self.listArr![index.row]
                        //                        NVYProfileDataTool.delectFriend(userID: model.FriendID, completion: { (result) in
                        //
                        //                            self.refresh()
                        //                        })
                        //
                        //                    }))
                        //
                        //                    self.navigationController?.present(alertController, animated: true, completion: nil)
                    }
                }
                
                return cell
            }else{
                tableView .register(UITableViewCell.self, forCellReuseIdentifier: "blankCell");
                let cell = tableView.dequeueReusableCell(withIdentifier: "blankCell", for: indexPath);
                cell.textLabel?.text = "暂无记录";
                cell.textLabel?.textAlignment = .center;
                return cell;
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            let vc = NVYMyNoteVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else {
            let count = listArr?.count ?? 0;
            if count > 0 {
                let model = listArr![indexPath.row]
                
                //            let chatVC = NVYConversationVC(conversationType: RCConversationType.ConversationType_PRIVATE, targetId: "\(model.ObjectUserInfoID)")
                ////        chatVC.conversationType = RCConversationType.ConversationType_PRIVATE
                ////        chatVC.targetId = "\()"
                //            chatVC?.title = model.ObjectNickName
                
                let nextVC = NVYFirendsDetailVC.init();
                nextVC.friendModel = model;
                self.navigationController?.pushViewController(nextVC, animated: true);
                //            self.navigationController?.pushViewController(chatVC!, animated: false)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
