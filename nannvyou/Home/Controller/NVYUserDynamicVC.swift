//
//  NVYUserDynamicVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/8/15.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import PKHUD
import ESPullToRefresh

class NVYUserDynamicVC: UITableViewController {
    
    var userID: Int = 0
    
    private var dataArr: Array<NVYHomeCellModel>?
    
    var currentPage: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataArr = Array()
        
        self.tableView.register(UINib.init(nibName: "NVYUserDynamicCell", bundle: Bundle.main), forCellReuseIdentifier: "NVYUserDynamicCell")
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "normalCell")
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    private func refresh() {
        self.currentPage = 1
        
        if userID != 0 {
            NVYHomeDataTool.getUserDynamicData(userID: userID, pageIndex: self.currentPage, completion: { (dataArray) in
                if dataArray.count > 0 {
                    self.dataArr = dataArray
                    
                    self.tableView.reloadData()
                }
                
                /// Stop refresh when your job finished, it will reset refresh footer if completion is true
                self.tableView.es.stopPullToRefresh(ignoreDate: true)
                /// Set ignore footer or not
                self.tableView.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
            })
        } else {
            NVYHomeDataTool.getHomeDynamicData(pageIndex: self.currentPage) { (dataArray) in
                
                if dataArray.count > 0 {
                    self.dataArr = dataArray
                    
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
        
        if userID != 0 {
            NVYHomeDataTool.getUserDynamicData(userID: userID, pageIndex: self.currentPage, completion: { (dataArray) in
                
                if dataArray.count > 0 {
                    for model in dataArray {
                        self.dataArr?.append(model)
                    }
                    self.tableView.reloadData()
                } else {
                    self.currentPage -= 1
                    HUD.flash(.labeledError(title: "无更多数据", subtitle: ""), delay: 1.5)
                }
                
                /// 如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
                self.tableView.es.stopLoadingMore()
            })
        } else {
            NVYHomeDataTool.getHomeDynamicData(pageIndex: self.currentPage) { (dataArray) in
                
                if dataArray.count > 0 {
                    for model in dataArray {
                        self.dataArr?.append(model)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ((self.dataArr?.count)! > 0) {
            return (self.dataArr?.count)!
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if ((self.dataArr?.count)! > 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NVYUserDynamicCell", for: indexPath) as! NVYUserDynamicCell
            
            cell.model = self.dataArr?[indexPath.row]

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell")
            
            cell?.textLabel?.text = "暂无数据"
            cell?.textLabel?.textAlignment = .center
            
            return cell!
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = NVYDynamicDetailVC()
        detailVC.detailModel = self.dataArr?[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
