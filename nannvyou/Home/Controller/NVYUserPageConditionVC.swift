//
//  NVYUserPageConditionVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/13.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

class NVYUserPageConditionVC: UITableViewController {

    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    var conditionInfo: NSDictionary?
    
    var infoModel: NVYFriendConditionModel?
    
    private let cellImages = [#imageLiteral(resourceName: "icon_birthday"), #imageLiteral(resourceName: "icon_map"), #imageLiteral(resourceName: "icon_area"), #imageLiteral(resourceName: "icon_bodyheight"), #imageLiteral(resourceName: "icon_body_weight"), #imageLiteral(resourceName: "icon_marry"), #imageLiteral(resourceName: "icon_education"), #imageLiteral(resourceName: "icon_hourse"), #imageLiteral(resourceName: "icon_car"), ]
    private let cellTitles = ["生日：", "地区：", "祖籍：", "身高：", "体重：", "婚史：", "学历：", "购房：", "购车："]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        screenHeight = screenFrame.height
        
        infoModel = Mapper<NVYFriendConditionModel>().map(JSONObject: conditionInfo)
        
        initTable()
        
    }
    
    private func initTable() {
        
        tableView.register(UINib.init(nibName: "NVYUserPageInfoCell", bundle: Bundle.main), forCellReuseIdentifier: "NVYUserPageInfoCell")
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return cellImages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NVYUserPageInfoCell") as? NVYUserPageInfoCell
        
        let img = UIImage.wz_changeImageTintColor(tintColor: UIColor.wz_colorWithHexString(hex: "#ff7da8"), image: cellImages[indexPath.row])
        cell?.iconView.image = img
        
        cell?.titleLabel.text = cellTitles[indexPath.row]
        cell?.titleLabel.textColor = UIColor.wz_colorWithHexString(hex: "#ff7da8")
        
        switch indexPath.row {
        case 0://生日
            cell?.descLabel.text = "\(infoModel?.AgeMin ?? 18)-\(infoModel?.AgeMax ?? 50)岁"
            cell?.descLabel.textColor = UIColor.lightGray
            break
            
        case 1://地区
            cell?.descLabel.text = infoModel?.areaDisplayString;//"\(infoModel?.ProvinceName ?? "") \(infoModel?.CityName ?? "") \(infoModel?.AreaName ?? "")"
            cell?.descLabel.textColor = UIColor.lightGray
            break
            
        case 2://祖籍
            cell?.descLabel.text = infoModel?.nativeAreaDisplayString;//"\(infoModel?.NativeProvinceName ?? "") \(infoModel?.NativeCityName ?? "") \(infoModel?.NativeAreaName ?? "")"
            cell?.descLabel.textColor = UIColor.lightGray
            break
            
        case 3://身高
            cell?.descLabel.text = "\(infoModel?.BodyHeightMin ?? 0)-\(infoModel?.BodyHeightMax ?? 0)cm"
            cell?.descLabel.textColor = UIColor.lightGray
            break
            
        case 4://体重
            cell?.descLabel.text = "\(infoModel?.BodyWeightMin ?? 0)-\(infoModel?.BodyWeightMax ?? 0)kg"
            cell?.descLabel.textColor = UIColor.lightGray
            break
            
        case 5://婚史
            cell?.descLabel.text = infoModel?.MaritalStatusName
            cell?.descLabel.textColor = UIColor.lightGray
            break
            
        case 6://学历
            cell?.descLabel.text = infoModel?.EducationName
            cell?.descLabel.textColor = UIColor.lightGray
            break
            
        case 7://购房
            cell?.descLabel.text = infoModel?.HouseName
            cell?.descLabel.textColor = UIColor.lightGray
            break
            
        case 8://购车
            cell?.descLabel.text = infoModel?.CarName
            cell?.descLabel.textColor = UIColor.lightGray
            break
            
        default:
            break
        }
        
        
        return cell!
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
