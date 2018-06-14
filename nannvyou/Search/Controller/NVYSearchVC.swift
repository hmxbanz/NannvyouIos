//
//  NVYSearchVC.swift
//  nanvyou
//
//  Created by MacMin-DLC0001 on 2017/5/10.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import Kingfisher
import PKHUD
import ESPullToRefresh

class NVYSearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    var searchView: NVYSearchingView? = nil
    var searchTable: UITableView? = nil
    
    var selectButton: UIButton? = nil
    
    var searchRequest: NVYSearchRequstModel?
    
    var searchDataArr: Array<NVYSearchResponseModel>?
    
    var currentPage: Int = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = false

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationItem.title = "搜索"
        
        view.backgroundColor = UIColor.white
        
        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        screenHeight = screenFrame.height
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "男女友", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        searchDataArr = Array()
        currentPage = 1
        
        view.addSubview(initSelectButton())
        
        searchRequest = initSearchRequest()
        
        view.addSubview(initSearchView())
        
    }
    
    func initSelectButton() -> UIButton {
        
        if selectButton == nil {
            let frame = CGRect(x: 0.0, y: 30.0, width: screenWidth!, height: 30.0)
            selectButton = UIButton(frame: frame)
            selectButton?.backgroundColor = UIColor.white
            selectButton?.isUserInteractionEnabled = false
            selectButton?.setTitle("选择以下条件搜索", for: UIControlState.normal)
            selectButton?.setTitle("展开搜索条件", for: UIControlState.selected)
            selectButton?.setTitleColor(UIColor.wz_colorWithHexString(hex: "#ff7da8"), for: UIControlState.normal)
            
            selectButton?.addTarget(self, action: #selector(selectButtonAction(btn:)), for: UIControlEvents.touchUpInside)
            
            let line = UILabel(frame: CGRect(x: 0, y: 29.5, width: screenWidth!, height: 0.5))
            line.backgroundColor = UIColor.groupTableViewBackground
            selectButton?.addSubview(line)
        }
        
        return selectButton!
    }
    
    func initSearchRequest() -> NVYSearchRequstModel {
        
        if searchRequest == nil {
            searchRequest = NVYSearchRequstModel()
            searchRequest?.sex = 1;
        }
        return searchRequest!
    }
    
    func selectButtonAction(btn: UIButton) {
        
        btn.isSelected = !btn.isSelected
        
        searchTable?.removeFromSuperview()
        
        selectButton?.isUserInteractionEnabled = false
    }

    func initSearchView() -> NVYSearchingView {
        
        if searchView == nil {
            
            searchView = Bundle.main.loadNibNamed("NVYSearchingView", owner: nil, options: nil)?.first as? NVYSearchingView
            let frame = CGRect(x: 0.0, y: 60.0, width: screenWidth!, height: 240.0)
            searchView?.frame = frame
            
            searchView?.sexBlock = { (_ btnTag: NSInteger) -> Void in
                
                print("sex tag \(btnTag)")
                self.searchRequest?.sex = 2 - btnTag
            }
            
            searchView?.statusBlcok = { (_ btnTag: NSInteger) -> Void in
                
                print("status tag \(btnTag)")
                self.searchRequest?.marry = btnTag - 1

            }
            
            searchView?.ageBlock = { () -> Void in
                
                let picker = Bundle.main.loadNibNamed("NVYSingleLinePicker", owner: nil, options: nil)?.first as? NVYSingleLinePicker
                picker?.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49.0 - 64.0)
                self.view.addSubview(picker!)
                
                let titles: NSArray = ["18-25", "26-30", "31-35", "36-40", "40以上"]
                
                picker?.pickerArr(array: titles)
                
                picker?.surePick = { (_ row: NSInteger) -> Void in
                    
                    self.searchView?.ageButton.setTitle(titles[row] as? String, for: UIControlState.normal)
                    self.searchRequest?.ageRange = titles[row] as? String
                }
            }
            
            //地址选择
            searchView?.cityBlock = { () -> Void in

                let addressPicker: NVYAddressPicker = Bundle.main.loadNibNamed("NVYAddressPicker", owner: nil, options: nil)?.first as! NVYAddressPicker
                addressPicker.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49 - 64)
            
                addressPicker.show(view: self.view, components: 2)
                                
                addressPicker.surePick = { (name, ID) -> Void in
                    
                    self.searchView?.cityButton.setTitle(name, for: UIControlState.normal)
                    
                    self.searchRequest?.area = name

                }
            }
            
            searchView?.searchBlock = { () -> Void in
                self.currentPage = 1;
                if self.searchRequest?.ageRange == nil {
                    self.searchRequest?.ageRange = "18-50";
//                    HUD.flash(.labeledError(title: "请选择年龄", subtitle: ""), delay: 1.5)
//                    return
                }
                if self.searchRequest?.area == nil {
                    self.searchRequest?.area = "";
//                    HUD.flash(.labeledError(title: "请选择城市", subtitle: ""), delay: 1.5)
//                    return
                }
                
                self.selectButton?.isUserInteractionEnabled = true
                self.selectButton?.isSelected = true

                self.view.addSubview(self.initTable())
                
                print("search acation")
                
                HUD.show(.systemActivity)

                NVYSearchDataTool.searchAction(page: self.currentPage, searchModel: self.searchRequest!, completion: { (dataArray) in
                                        
                    if dataArray.count > 0 {
                        self.searchDataArr = dataArray;
                        self.searchTable?.reloadData();
                        self.searchTable?.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true);
                    } else {
//                        HUD.flash(.labeledError(title: "暂无数据", subtitle: ""), delay: 1.5)
                        self.searchDataArr = Array()
                        self.searchTable?.reloadData()
                    }
                })
                
                
                var header: ESRefreshProtocol & ESRefreshAnimatorProtocol
                var footer: ESRefreshProtocol & ESRefreshAnimatorProtocol
                
                header = ESRefreshHeaderAnimator.init(frame: CGRect.zero)
                footer = ESRefreshFooterAnimator.init(frame: CGRect.zero)
                
                
                self.searchTable?.es.addPullToRefresh(animator: header) { [unowned self] in
                    self.refresh()
                }
                
                self.searchTable?.es.addInfiniteScrolling(animator: footer) { [unowned self] in
                    self.loadMore()
                }
                //        searchTable?.refreshIdentifier = String.init(describing: type)
                //        searchTable?.expiredTimeInterval = 20.0
                
            }
        }
        
        return searchView!
    }

    private func refresh() {
        self.currentPage = 1
        NVYSearchDataTool.searchAction(page: self.currentPage, searchModel: self.searchRequest!, completion: { (dataArray) in
            
            if dataArray.count > 0 {
                self.searchDataArr = dataArray 
                self.searchTable?.reloadData()
                
            } else {
                HUD.flash(.labeledError(title: "暂无数据", subtitle: ""), delay: 1.5)
            }
            
            /// Stop refresh when your job finished, it will reset refresh footer if completion is true
            self.searchTable?.es.stopPullToRefresh(ignoreDate: true)
            /// Set ignore footer or not
            self.searchTable?.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
        })
    }

    private func loadMore() {
        self.currentPage += 1
        NVYSearchDataTool.searchAction(page: self.currentPage, searchModel: self.searchRequest!, completion: { (dataArray) in
            
            if dataArray.count > 0 {
                for model in dataArray {
                    self.searchDataArr?.append(model)
                }
                self.searchTable?.reloadData()
            } else {
                self.currentPage -= 1
                HUD.flash(.labeledError(title: "无更多数据", subtitle: ""), delay: 1.5)
            }
            
            /// 如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
            self.searchTable?.es.stopLoadingMore()
            /// 通过es_noticeNoMoreData()设置footer暂无数据状态
//            self.searchTable?.es_noticeNoMoreData()
            
        })
    }

    func initTable() -> UITableView {
        
        if searchTable == nil {
            let frame = CGRect(x: 0.0, y: 60.0, width: screenWidth!, height: screenHeight! - 60.0 - 50)
            searchTable = UITableView(frame: frame, style: UITableViewStyle.plain)
            searchTable?.rowHeight  = 100
            searchTable?.delegate   = self
            searchTable?.dataSource = self
            searchTable?.backgroundColor = UIColor.groupTableViewBackground
//            searchTable?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "searchCell")
            searchTable?.register(UINib.init(nibName: "NVYSearchCell", bundle: Bundle.main), forCellReuseIdentifier: "searchCell")
            searchTable?.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.01))
        }
        
        return searchTable!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension NVYSearchVC {
    
    ///MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = searchDataArr?.count ?? 0;
        if count == 0 {
            count = 1;
        }
        return count;
//        return (searchDataArr?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let count = searchDataArr?.count ?? 0;
        if count > 0 {
            let cell: NVYSearchCell = tableView.dequeueReusableCell(withIdentifier: "searchCell")! as! NVYSearchCell
            //        var cell = tableView.dequeueReusableCell(withIdentifier: "searchCell")!
            
            //        cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "searchCell")
            
            let model = self.searchDataArr![indexPath.row]
            
            let imgStr = "\(kBaseURL)\(model.IconSmall ?? "")"
            let imgURL = NSURL(string: imgStr)
            let imgResource = ImageResource(downloadURL: imgURL! as URL, cacheKey: imgStr)
            cell.userIcon?.kf.setImage(with: imgResource, placeholder: Image(named: "icon_head"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in
                
            })
            cell.nameLabel?.text = model.NickName
            cell.addressLabel?.text = model.ProvinceName?.appending(model.CityName!)
            
            return cell
        }else{
            tableView .register(UITableViewCell.self, forCellReuseIdentifier: "blankCell");
            let cell = tableView.dequeueReusableCell(withIdentifier: "blankCell", for: indexPath);
            cell.textLabel?.text = "暂无记录";
            cell.textLabel?.textAlignment = .center;
            return cell;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let count = searchDataArr?.count ?? 0;
        if count > 0 {
            let model = self.searchDataArr![indexPath.row]
            
            let vc = NVYUserPageVC()
            vc.userInfoID = model.UserInfoID
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
