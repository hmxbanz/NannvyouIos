//
//  NVYPerConditionVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/9.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

class NVYPerConditionVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NVYTextViewCellDelegate {

    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    var conditionTable: UITableView?
    
    let cellImages = [#imageLiteral(resourceName: "icon_map"), #imageLiteral(resourceName: "icon_area"), #imageLiteral(resourceName: "icon_birthday"), #imageLiteral(resourceName: "icon_bodyheight"), #imageLiteral(resourceName: "icon_body_weight"), #imageLiteral(resourceName: "icon_education"), #imageLiteral(resourceName: "icon_marry"), #imageLiteral(resourceName: "icon_salary"), #imageLiteral(resourceName: "icon_hourse"), #imageLiteral(resourceName: "icon_car"), #imageLiteral(resourceName: "icon_info")]
    let cellTitles = ["地区：", "祖籍：", "年龄：", "身高：", "体重：", "学历：", "婚史：", "月入：", "购房：", "购车：", "备注："]
    
    var editModel: NVYUserEditConditionModel?
    
    var textView: UITextView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        screenHeight = screenFrame.height
        
        navigationItem.title = "择偶条件"
        
        view.addSubview(initConditionTable())
        
        editModel = NVYUserEditConditionModel()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveEditInfo))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow_left"), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
    }
    
    func backAction() {
        
        self.view.endEditing(true)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveEditInfo() {
        
        editModel?.Remark = textView?.text
        
//        NVYProfileDataTool.set
//        }
    }
    
    func initConditionTable() -> UITableView {
        
        if conditionTable == nil {
            let frame = CGRect(x: 0.0, y: 0.0, width: screenWidth!, height: screenHeight!)
            conditionTable = UITableView(frame: frame, style: UITableViewStyle.plain)
            conditionTable?.delegate   = self
            conditionTable?.dataSource = self
            conditionTable?.backgroundColor = UIColor.groupTableViewBackground
            
//            infoTable?.register(UINib.init(nibName: "NVYSearchCell", bundle: Bundle.main), forCellReuseIdentifier: "searchCell")
            conditionTable?.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.01))
        }
        
        return conditionTable!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

extension NVYPerConditionVC {
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 11
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 10 {
            return 100
        }
        
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //        var cell = tableView.dequeueReusableCell(withIdentifier: "cell\(indexPath.row)", for: indexPath)
        
        if indexPath.row == 10 {
            
            let cell = Bundle.main.loadNibNamed("NVYTextViewCell", owner: nil, options: nil)?.first as? NVYTextViewCell
            
            let img = UIImage.wz_changeImageTintColor(tintColor: UIColor.wz_colorWithHexString(hex: "#ff7da8"), image: cellImages[indexPath.row])
            cell?.iconView?.image = img
            cell?.delegate = self
            
            cell?.titleLabel?.text = cellTitles[indexPath.row]
            
            textView = cell?.textView
            
            cell?.textView.text = editModel?.Remark
            
            return cell!
            
        } else {
            
            let cell = Bundle.main.loadNibNamed("NVYPickerCell", owner: nil, options: nil)?.first as? NVYPickerCell
            
            let img = UIImage.wz_changeImageTintColor(tintColor: UIColor.wz_colorWithHexString(hex: "#ff7da8"), image: cellImages[indexPath.row])
            cell?.iconView?.image = img
            
            cell?.titleLabel?.text = cellTitles[indexPath.row]
            
            switch indexPath.row {
            case 0:
                cell?.selectBtn.text = editModel?.Area ?? "请选择"
                break
            case 1:
                cell?.selectBtn.text = editModel?.NativeArea ?? "请选择"
                break
            case 2:
                cell?.selectBtn.text = editModel?.AgeRange ?? "请选择"
                break
            case 3:
                cell?.selectBtn.text = editModel?.BodyHeight ?? "请选择"
                break
            case 4:
                cell?.selectBtn.text = editModel?.BodyWeight ?? "请选择"
                break
            case 5:
                cell?.selectBtn.text = editModel?.Education ?? "请选择"
                break
            case 6:
                cell?.selectBtn.text = editModel?.MaritalStatus ?? "请选择"
                break
            case 7:
                cell?.selectBtn.text = editModel?.Salary ?? "请选择"
                break
            case 8:
                cell?.selectBtn.text = editModel?.House ?? "请选择"
                break
            case 9:
                cell?.selectBtn.text = editModel?.Car ?? "请选择"
                break
                
            default:
                break
            }
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {//地区
            
            let addressPicker: NVYAddressPicker = Bundle.main.loadNibNamed("NVYAddressPicker", owner: nil, options: nil)?.first as! NVYAddressPicker
            addressPicker.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49)
            
            addressPicker.show(view: self.view, components: 3)
            
            addressPicker.surePick = { (name, ID) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                
                cell.selectBtn.text = name
                
//                self.editModel?.Area = name
                
                NVYProfileDataTool.setSingleCondition(info: name, apiName: "Area", completion: { (Bool) in
                    
                })
            }
        } else if (indexPath.row == 1) {//祖籍
            
            let addressPicker: NVYAddressPicker = Bundle.main.loadNibNamed("NVYAddressPicker", owner: nil, options: nil)?.first as! NVYAddressPicker
            addressPicker.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49)
            
            addressPicker.show(view: self.view, components: 3)
            
            addressPicker.surePick = { (name, ID) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                
                cell.selectBtn.text = name
                
//                self.editModel?.NativeArea = name
                
                NVYProfileDataTool.setSingleCondition(info: name, apiName: "NativeArea", completion: { (Bool) in
                    
                })
                
            }
            
        } else if (indexPath.row == 2) {//年龄
            
            let picker = Bundle.main.loadNibNamed("NVYDoubleLinePicker", owner: nil, options: nil)?.first as? NVYDoubleLinePicker
            picker?.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49)
            self.view.addSubview(picker!)
            
            let titles = NSMutableArray()
            
            for i in 0...40 {
                titles.add("\(i + 20)")
            }
            
            picker?.pickerArr(array: titles)
            
            picker?.lastTitle(title: "岁")
            
            picker?.surePicker = { (_ row1: NSInteger, row2: NSInteger) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                
                cell.selectBtn.text = "\(titles[row1])岁-\(titles[row2])岁"
                
//                self.editModel?.AgeRange = cell.selectBtn.text
                
                NVYProfileDataTool.setSingleCondition(info: "\(titles[row1])岁 \(titles[row2])岁", apiName: "AgeRange", completion: { (Bool) in
                    
                })
            }
            
        } else if (indexPath.row == 3) {//身高
            
            let picker = Bundle.main.loadNibNamed("NVYDoubleLinePicker", owner: nil, options: nil)?.first as? NVYDoubleLinePicker
            picker?.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49)
            self.view.addSubview(picker!)
            
            let titles = NSMutableArray()
            
            for i in 0...60 {
                titles.add("\(i * 5 + 140)")
            }
            
            picker?.pickerArr(array: titles)
            
            picker?.surePicker = { (_ row1: NSInteger, row2: NSInteger) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                
                cell.selectBtn.text = "\(titles[row1])CM-\(titles[row2])CM"
                
//                self.editModel?.BodyHeight = cell.selectBtn.text
                
                NVYProfileDataTool.setSingleCondition(info: "\(titles[row1])CM \(titles[row2])CM", apiName: "BodyHeight", completion: { (Bool) in
                    
                })
            }
            
        } else if (indexPath.row == 4) {//体重
            
            let picker = Bundle.main.loadNibNamed("NVYDoubleLinePicker", owner: nil, options: nil)?.first as? NVYDoubleLinePicker
            picker?.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49)
            self.view.addSubview(picker!)
            
            let titles = NSMutableArray()
            
            for i in 0...16 {
                titles.add("\(i * 5 + 30)")
            }
            
            picker?.pickerArr(array: titles)
            
            picker?.lastTitle(title: "KG")
            
            picker?.surePicker = { (_ row1: NSInteger, row2: NSInteger) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                
                cell.selectBtn.text = "\(titles[row1])KG-\(titles[row2])KG"
                
//                self.editModel?.BodyWeight = cell.selectBtn.text
                
                NVYProfileDataTool.setSingleCondition(info: "\(titles[row1])KG \(titles[row2])KG", apiName: "BodyWeight", completion: { (Bool) in
                    
                })
            }
            
        } else if (indexPath.row == 5) {//学历
            
            let picker = Bundle.main.loadNibNamed("NVYSingleLinePicker", owner: nil, options: nil)?.first as? NVYSingleLinePicker
            picker?.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49)
            self.view.addSubview(picker!)
            
            let nations = NVYProfileDataTool().getEducation()
            
            let titles = NSMutableArray()
            
            for item in nations {
                let model = item as! NVYSysObjModel
                titles.add(model.Name!)
            }
            
            picker?.pickerArr(array: titles)
            
            picker?.surePick = { (_ row: NSInteger) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                
                cell.selectBtn.text = titles[row] as? String
                
//                self.editModel?.Education = cell.selectBtn.text
                
                NVYProfileDataTool.setSingleCondition(info: cell.selectBtn.text!, apiName: "Education", completion: { (Bool) in
                    
                })
            }
            
        } else if (indexPath.row == 6) {//婚史
            
            let picker = Bundle.main.loadNibNamed("NVYSingleLinePicker", owner: nil, options: nil)?.first as? NVYSingleLinePicker
            picker?.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49)
            self.view.addSubview(picker!)
            
            let nations = NVYProfileDataTool().getMarry()
            
            let titles = NSMutableArray()
            
            for item in nations {
                let model = item as! NVYSysObjModel
                titles.add(model.Name!)
            }
            
            picker?.pickerArr(array: titles)
            
            picker?.surePick = { (_ row: NSInteger) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                
                cell.selectBtn.text = titles[row] as? String
                
//                self.editModel?.MaritalStatus = cell.selectBtn.text
                
                NVYProfileDataTool.setSingleCondition(info: cell.selectBtn.text!, apiName: "MaritalStatus", completion: { (Bool) in
                    
                })
            }
            
        } else if (indexPath.row == 7) {//月入
            
            let picker = Bundle.main.loadNibNamed("NVYSingleLinePicker", owner: nil, options: nil)?.first as? NVYSingleLinePicker
            picker?.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49)
            self.view.addSubview(picker!)
            
            let nations = NVYProfileDataTool().getSalary()
            
            let titles = NSMutableArray()
            
            for item in nations {
                let model = item as! NVYSysObjModel
                titles.add(model.Name!)
            }
            
            picker?.pickerArr(array: titles)
            
            picker?.surePick = { (_ row: NSInteger) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                
                cell.selectBtn.text = titles[row] as? String
                
//                self.editModel?.Salary = cell.selectBtn.text
                
                NVYProfileDataTool.setSingleCondition(info: cell.selectBtn.text!, apiName: "Salary", completion: { (Bool) in
                    
                })
            }
            
        } else if (indexPath.row == 8) {//购房

            let picker = Bundle.main.loadNibNamed("NVYSingleLinePicker", owner: nil, options: nil)?.first as? NVYSingleLinePicker
            picker?.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49)
            self.view.addSubview(picker!)
            
            let nations = NVYProfileDataTool().getHouse()
            
            let titles = NSMutableArray()
            
            for item in nations {
                let model = item as! NVYSysObjModel
                titles.add(model.Name!)
            }
            
            picker?.pickerArr(array: titles)
            
            picker?.surePick = { (_ row: NSInteger) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                
                cell.selectBtn.text = titles[row] as? String
                
//                self.editModel?.House = cell.selectBtn.text
                
                NVYProfileDataTool.setSingleCondition(info: cell.selectBtn.text!, apiName: "House", completion: { (Bool) in
                    
                })
            }
            
        } else if (indexPath.row == 9) {//购车
            
            let picker = Bundle.main.loadNibNamed("NVYSingleLinePicker", owner: nil, options: nil)?.first as? NVYSingleLinePicker
            picker?.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49)
            self.view.addSubview(picker!)
            
            let nations = NVYProfileDataTool().getCar()
            
            let titles = NSMutableArray()
            
            for item in nations {
                let model = item as! NVYSysObjModel
                titles.add(model.Name!)
            }
            
            picker?.pickerArr(array: titles)
            
            picker?.surePick = { (_ row: NSInteger) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                
                cell.selectBtn.text = titles[row] as? String
                
//                self.editModel?.Car = cell.selectBtn.text
                
                NVYProfileDataTool.setSingleCondition(info: cell.selectBtn.text!, apiName: "Car", completion: { (Bool) in
                    
                })
            }
        }
        
    }
    
    //MARK: - NVYTextViewCellDelegate
    func finishTVEdit(cell: NVYTextViewCell, text: String) {
        
        NVYProfileDataTool.setSingleCondition(info: text, apiName: "Remark") { (Bool) in
            
        }
    }

}
