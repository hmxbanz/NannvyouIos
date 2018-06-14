//
//  NVYMyChargeVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/25.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

//消费记录

import UIKit
import PKHUD
import ESPullToRefresh

class NVYMyChargeVC: UITableViewController {
    
    var dataArr: Array<NVYMyChargeModel>?

    var currentPage: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        dataArr = Array()
        
        navigationItem.title = "会员记录"
        
        tableView.rowHeight = 70.0
        tableView.register(UINib.init(nibName: "NVYMyChargeCell", bundle: Bundle.main), forCellReuseIdentifier: "NVYMyChargeCell")
        
        
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
        NVYProfileDataTool.fetchMyCharge(page: self.currentPage) { (dataArray) in
        
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
    
    private func loadMore() {
        self.currentPage += 1
        NVYProfileDataTool.fetchMyCharge(page: self.currentPage) { (dataArray) in
            
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
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = dataArr?.count ?? 0;
        if count == 0 {
            count = 1;
        }
        return count;
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let count = dataArr?.count ?? 0;
        if count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NVYMyChargeCell", for: indexPath) as! NVYMyChargeCell
            let model = dataArr![indexPath.row]
            cell.titleLabel?.text = model.ProductName
            cell.remarkLabel.text = model.Remark
            cell.typeLabel.text = "\(model.Price)"
            
            return cell
        }else{
            tableView .register(UITableViewCell.self, forCellReuseIdentifier: "blankCell");
            let cell = tableView.dequeueReusableCell(withIdentifier: "blankCell", for: indexPath);
            cell.textLabel?.text = "暂无记录";
            cell.textLabel?.textAlignment = .center;
            return cell;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
