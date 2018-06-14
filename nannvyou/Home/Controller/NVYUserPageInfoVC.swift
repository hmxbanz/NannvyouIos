//
//  NVYUserPageInfoVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/11.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

class NVYUserPageInfoVC: UITableViewController {

    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    //传入数据
    var userInfo: NSDictionary?
    //把传入的数据转为模型
    var userModel: NVYUserModel?
    

    private let cellImages = [#imageLiteral(resourceName: "icon_nation"), #imageLiteral(resourceName: "icon_map"), #imageLiteral(resourceName: "icon_area"), /*#imageLiteral(resourceName: "icon_birthday"),*/ #imageLiteral(resourceName: "icon_bodyheight"), #imageLiteral(resourceName: "icon_body_weight"), #imageLiteral(resourceName: "icon_occupation"), #imageLiteral(resourceName: "icon_marry"), #imageLiteral(resourceName: "icon_education"), #imageLiteral(resourceName: "icon_hourse"), #imageLiteral(resourceName: "icon_car"), ]
    private let cellTitles = ["民族", "地区", "祖籍", /*"生日",*/ "身高", "体重", "职业", "婚史", "学历", "购房", "购车"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        screenHeight = screenFrame.height
        
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))
        tableView.register(UINib.init(nibName: "NVYUserPageInfoCell", bundle: Bundle.main), forCellReuseIdentifier: "NVYUserPageInfoCell")
        
        userModel = Mapper<NVYUserModel>().map(JSONObject: userInfo)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    
    //MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return cellTitles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NVYUserPageInfoCell") as? NVYUserPageInfoCell
        
        let img = UIImage.wz_changeImageTintColor(tintColor: UIColor.wz_colorWithHexString(hex: "#ff7da8"), image: cellImages[indexPath.row])
        cell?.iconView.image = img
        
        let title = cellTitles[indexPath.row];
        cell?.titleLabel.text = title + "：";//cellTitles[indexPath.row]
        cell?.titleLabel.textColor = UIColor.wz_colorWithHexString(hex: "#ff7da8")
        
        if (title == "民族") {
            cell?.descLabel.text = userModel?.NationName
            cell?.descLabel.textColor = UIColor.lightGray
        }else if (title == "地区"){
            cell?.descLabel.text = userModel?.areaDisplayString; //userModel?.AreaName
            cell?.descLabel.textColor = UIColor.lightGray
        }else if (title == "祖籍"){
            cell?.descLabel.text = userModel?.nativeAreaDisplayString;//userModel?.NativeAreaName
            cell?.descLabel.textColor = UIColor.lightGray
        }else if (title == "生日"){
            cell?.descLabel.text = userModel?.Birthday?.lwz_getShortTime()
            cell?.descLabel.textColor = UIColor.lightGray
        }else if (title == "身高"){
            cell?.descLabel.text = "\(userModel?.BodyHeight ?? 0)cm"
            cell?.descLabel.textColor = UIColor.lightGray
        }else if (title == "体重"){
            cell?.descLabel.text = "\(userModel?.BodyWeight ?? 0)kg"
            cell?.descLabel.textColor = UIColor.lightGray
        }else if (title == "职业"){
            cell?.descLabel.text = userModel?.IndustryName
            cell?.descLabel.textColor = UIColor.lightGray
        }else if (title == "婚史"){
            cell?.descLabel.text = userModel?.MaritalStatusName
            cell?.descLabel.textColor = UIColor.lightGray
        }else if (title == "学历"){
            cell?.descLabel.text = userModel?.EducationName
            cell?.descLabel.textColor = UIColor.lightGray
        }else if (title == "购房"){
            cell?.descLabel.text = userModel?.HouseName
            cell?.descLabel.textColor = UIColor.lightGray
        }else if (title == "购车"){
            cell?.descLabel.text = userModel?.CarName
            cell?.descLabel.textColor = UIColor.lightGray
        }else{
            cell?.descLabel.text = "";
            cell?.descLabel.textColor = UIColor.lightGray
        }
        
        
        return cell!
    }
    
}
