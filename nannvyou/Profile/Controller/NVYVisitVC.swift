//
//  NVYVisitVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/18.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import Kingfisher
import PKHUD
import ESPullToRefresh

class NVYVisitVC: UITableViewController {

    var dataArr: Array<NVYVisitModel>?
    
    var currentType: Int = 0
    
    var currentPage: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "谁看了我"
        
        dataArr = Array()
        
        tableView.rowHeight = 60.0
        tableView.register(UINib.init(nibName: "NVYVisitCell", bundle: Bundle.main), forCellReuseIdentifier: "NVYVisitCell")
        
        let control = BetterSegmentedControl(
            frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: 44.0),
            titles: ["谁看过我", "我看过谁"],
            index: 0,
            backgroundColor: .white,
            titleColor: .black,
            indicatorViewBackgroundColor: UIColor.wz_colorWithHexString(hex: "ff7da8"),
            selectedTitleColor: .white)
        control.bouncesOnChange = false
        control.panningDisabled = false
        
        control.titleFont = UIFont(name: "HelveticaNeue", size: 14.0)!
        control.selectedTitleFont = UIFont(name: "HelveticaNeue-Medium", size: 14.0)!
        control.addTarget(self, action: #selector(changeData(obj:)), for: .valueChanged)
        tableView.tableHeaderView = control;
        
        self.refresh()
        
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
    
    private func refresh() {
        self.currentPage = 1
        
        if currentType != 0 {
            
            NVYProfileDataTool.fetchWhoIVisited(page:self.currentPage) { (dataArray) in
                
                if dataArray.count > 0 {
                    self.dataArr = dataArray as? Array<NVYVisitModel>
                    
                    self.tableView.reloadData()
                }
                
                /// Stop refresh when your job finished, it will reset refresh footer if completion is true
                self.tableView.es.stopPullToRefresh(ignoreDate: true)
                /// Set ignore footer or not
                self.tableView.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
            }
        } else {
            NVYProfileDataTool.fetchWhoVisitedMe(page:self.currentPage) { (dataArray) in
                
                if dataArray.count > 0 {
                    self.dataArr = dataArray as? Array<NVYVisitModel>
                    
                    self.tableView.reloadData()
                }
                
                /// Stop refresh when your job finished, it will reset refresh footer if completion is true
                self.tableView.es.stopPullToRefresh(ignoreDate: true)
                /// Set ignore footer or not
                self.tableView.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
            }
        }
    }
    
    private func loadMore() {
        self.currentPage += 1
        
        if currentType != 0 {
            
            NVYProfileDataTool.fetchWhoIVisited(page:self.currentPage) { (dataArray) in
                
                if dataArray.count > 0 {
                    for model in dataArray {
                        self.dataArr?.append(model as! NVYVisitModel)
                    }
                    self.tableView.reloadData()
                } else {
                    self.currentPage -= 1
                    HUD.flash(.labeledError(title: "无更多数据", subtitle: ""), delay: 1.5)
                }
                
                /// 如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
                self.tableView.es.stopLoadingMore()
            }
        } else {
            NVYProfileDataTool.fetchWhoVisitedMe(page:self.currentPage) { (dataArray) in
                
                if dataArray.count > 0 {
                    for model in dataArray {
                        self.dataArr?.append(model as! NVYVisitModel)
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
    }
    
    func changeData(obj: BetterSegmentedControl) {
        
        currentType = Int(obj.index)
        
        self.currentPage = 1
        
        if currentType != 0 {

            NVYProfileDataTool.fetchWhoIVisited(page:self.currentPage) { (result) in
                
                self.dataArr = result as? Array<NVYVisitModel>
                self.tableView.reloadData()
            }
        } else {
            NVYProfileDataTool.fetchWhoVisitedMe(page:self.currentPage) { (result) in
                
                self.dataArr = result as? Array<NVYVisitModel>
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataArr?.count)!
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "NVYVisitCell") as? NVYVisitCell
        
        let model = dataArr![indexPath.row] 
        
        var imgStr = "\(kBaseURL)\(model.OwnerIcon ?? "")"
        if currentType != 0 {
            imgStr = "\(kBaseURL)\(model.ObjectIcon ?? "")"
        }
        
        let imgURL = NSURL(string: imgStr)
        let imgResource = ImageResource(downloadURL: imgURL! as URL, cacheKey: imgStr)
        cell?.userIcon?.kf.setImage(with: imgResource, placeholder: Image(named: "icon_head"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in
            
        })
        
        if currentType != 0 {
            cell?.nameLabel.text = model.ObjectNickName
        } else {
            cell?.nameLabel.text = model.OwnerNickName
        }
        
        cell?.timeLabel.text = model.CreateDate?.lwz_changeTime()

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = dataArr![indexPath.row]

        let vc = NVYUserPageVC()
        if currentType != 0 {
            vc.userInfoID = model.ObjectUserInfoID
        } else {
            vc.userInfoID = model.OwnerUserInfoID
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
