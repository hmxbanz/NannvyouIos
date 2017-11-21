//
//  NVYMyNoteVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/9/12.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import Kingfisher
import PKHUD
import ESPullToRefresh

class NVYMyNoteVC: UITableViewController {

    var listArr: Array<NVYNoteModel>?
    
    var currentPage: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listArr = Array()

        navigationItem.title = "消息列表"
        
        self.tableView.register(UINib.init(nibName: "NVYMyNoteCell", bundle: Bundle.main), forCellReuseIdentifier: "NVYMyNoteCell")
        self.tableView.rowHeight = 80.0
        
        self.refresh()
        
        var header: ESRefreshProtocol & ESRefreshAnimatorProtocol
        var footer: ESRefreshProtocol & ESRefreshAnimatorProtocol
        
        header = ESRefreshHeaderAnimator.init(frame: CGRect.zero)
        footer = ESRefreshFooterAnimator.init(frame: CGRect.zero)
        
        self.tableView?.es_addPullToRefresh(animator: header) { [unowned self] in
            self.refresh()
        }
        
        self.tableView?.es_addInfiniteScrolling(animator: footer) { [unowned self] in
            self.loadMore()
        }
    }
    
    private func refresh() {
        self.currentPage = 1
        NVYProfileDataTool.getUserNotes(page: self.currentPage) { (notes) in
            
            if notes.count > 0 {
                self.listArr = notes
                
                self.tableView.reloadData()
            }
            
            /// Stop refresh when your job finished, it will reset refresh footer if completion is true
            self.tableView.es_stopPullToRefresh(ignoreDate: true)
            /// Set ignore footer or not
            self.tableView.es_stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
        }
    }
    
    private func loadMore() {
        self.currentPage += 1
        NVYProfileDataTool.getUserNotes(page: self.currentPage) { (notes) in
            
            if notes.count > 0 {
                for model in notes {
                    self.listArr?.append(model)
                }
                self.tableView.reloadData()
            } else {
                self.currentPage -= 1
                HUD.flash(.labeledError(title: "无更多数据", subtitle: ""), delay: 1.5)
            }
            
            /// 如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
            self.tableView.es_stopLoadingMore()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (listArr?.count)!
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NVYMyNoteCell", for: indexPath) as? NVYMyNoteCell
        cell?.selectionStyle = .none
        cell?.path = indexPath as NSIndexPath

        if (listArr?.count)! > 0 {
            let model = listArr![indexPath.row]
            
            let user = NVYUserModel.getUserModel()
            var imgStr = ""
            if model.OwnerUserInfoID == user.UserInfoID {
                imgStr = "\(kBaseURL)\(model.ObjectIconSmall ?? "")"
                cell?.userNameLabel.text = "\(model.ObjectNickName ?? "")"
            } else {
                imgStr = "\(kBaseURL)\(model.OwnerIconSmall ?? "")"
                cell?.userNameLabel.text = "\(model.OwnerNickName ?? "")"
            }
            
            let imgURL = NSURL(string: imgStr)
            let imgResource = ImageResource(downloadURL: imgURL! as URL, cacheKey: imgStr)
            cell?.userIcon?.kf.setImage(with: imgResource, placeholder: Image(named: "icon_head"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in
                
            })
            
            cell?.timeLabel.text = "\(model.CreateDate?.lwz_changeTime() ?? "")"
            
            if (model.noteType == 3 || model.noteType == 2) {
                let title = (model.noteType == 2) ? "已发送" : "已同意";
                cell?.agreeBtn.isEnabled = false;
                cell?.agreeBtn.setTitle(title, for: .normal);
//                cell?.agreeBtn.isHidden = true
            } else {
                cell?.agreeBtn.isEnabled = true;
                cell?.agreeBtn.setTitle("同意", for: .normal);
                cell?.agreeBlock = { (path) in //同意添加好友
                    
                    let model = self.listArr![path.row]

                    let alertController = UIAlertController(title: "同意添加好友?", message: nil, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
                    alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { (UIAlertAction) in
                        
                        NVYProfileDataTool.agreeAddFriend(messageId: model.MessageID, completion: { (result) in
                            
                            if result {
                                self.refresh()
                            }
                        })
                        
                    }))
                    
                    self.navigationController?.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
        return cell!
    }
}
