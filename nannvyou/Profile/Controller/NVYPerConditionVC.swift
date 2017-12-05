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
    
    var editModel: NVYFriendConditionModel?
    
    var textView: UITextView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        screenHeight = screenFrame.height
        
        navigationItem.title = "择偶条件"
        
        view.addSubview(initConditionTable())
        
        editModel = NVYFriendConditionModel.getUserConditionModel();
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveEditInfo))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow_left"), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        addKeyboardNotification();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        removeKeyboardNotification();
    }
    
    func backAction() {
        
        self.view.endEditing(true)
        
        _ = NVYFriendConditionModel.saveConditionModel(self.editModel!);
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveEditInfo() {
        self.view.endEditing(true);
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        if conditionTable != nil {
            conditionTable?.frame = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height: self.view.bounds.height);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: 键盘事件
    func keyboardWillShowNotification(notify:Notification) -> Void {
        if let keyboardSize = (notify.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print(keyboardSize);
            var frame = self.conditionTable?.frame;
            frame?.size.height = screenHeight! - keyboardSize.height - 64;
            UIView.animate(withDuration: 0.28) {
                self.conditionTable?.frame = frame!;
            };
        }
    }
    
    func keyboardWillHideNotification(notify:Notification) -> Void {
        var frame = self.conditionTable?.frame;
        frame?.size.height = screenHeight!;
        UIView.animate(withDuration: 0.28) {
            self.conditionTable?.frame = frame!;
        };
    }
    
    func addKeyboardNotification() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(NVYPerConditionVC.keyboardWillShowNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(NVYPerConditionVC.keyboardWillHideNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    func removeKeyboardNotification() -> Void {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil);
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
                cell?.selectBtn.text = editModel?.addressString() ?? "请选择"
                break
            case 1:
                cell?.selectBtn.text = editModel?.nativeAddressString() ?? "请选择"
                break
            case 2:
                cell?.selectBtn.text = editModel?.ageRangeString() ?? "请选择"
                break
            case 3:
                cell?.selectBtn.text = editModel?.bodyHeightRangeString() ?? "请选择"
                break
            case 4:
                cell?.selectBtn.text = editModel?.bodyWeightRangeString() ?? "请选择"
                break
            case 5:
                cell?.selectBtn.text = editModel?.EducationName ?? "请选择"
                break
            case 6:
                cell?.selectBtn.text = editModel?.MaritalStatusName ?? "请选择"
                break
            case 7:
                cell?.selectBtn.text = editModel?.SalaryName ?? "请选择"
                break
            case 8:
                cell?.selectBtn.text = editModel?.HouseName ?? "请选择"
                break
            case 9:
                cell?.selectBtn.text = editModel?.CarName ?? "请选择"
                break
                
            default:
                break
            }
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true);
        if indexPath.row == 0 {//地区
            
            let addressPicker: NVYAddressPicker = Bundle.main.loadNibNamed("NVYAddressPicker", owner: nil, options: nil)?.first as! NVYAddressPicker
            addressPicker.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49)
            
            addressPicker.show(view: self.view, components: 3)
            
            addressPicker.confrimBlock = { (provice: NVYProviceModel?, city: NVYCityModel?, area: NVYAreaModel?) -> Void in
                let addressName = self.editModel?.areaNameString(province: provice, city: city, area: area);
                NVYProfileDataTool.setSingleCondition(info: addressName!, apiName: "Area", completion: { (Bool) in
                    if Bool {
                        self.editModel?.updateAddresInfo(province: provice, city: city, area: area);
                        let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell;
                        cell.selectBtn.text = self.editModel?.addressString();
                    }
                })
            };
//            addressPicker.surePick = { (name, ID) -> Void in
////                self.editModel?.Area = name
//                NVYProfileDataTool.setSingleCondition(info: name, apiName: "Area", completion: { (Bool) in
//                    if Bool {
//                        let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell;
//                        cell.selectBtn.text = name;
//                    }
//                })
//            }
        } else if (indexPath.row == 1) {//祖籍
            
            let addressPicker: NVYAddressPicker = Bundle.main.loadNibNamed("NVYAddressPicker", owner: nil, options: nil)?.first as! NVYAddressPicker
            addressPicker.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49)
            
            addressPicker.show(view: self.view, components: 3)
            
            addressPicker.confrimBlock = { (provice: NVYProviceModel?, city: NVYCityModel?, area: NVYAreaModel?) -> Void in
                let addressName = self.editModel?.areaNameString(province: provice, city: city, area: area);
                NVYProfileDataTool.setSingleCondition(info: addressName!, apiName: "NativeArea", completion: { (Bool) in
                    if Bool {
                        self.editModel?.updateNativeAddressInfo(province: provice, city: city, area: area);
                        let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell;
                        cell.selectBtn.text = self.editModel?.nativeAddressString();
                    }
                })
            };
            
//            addressPicker.surePick = { (name, ID) -> Void in
//
//                let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
//
//                cell.selectBtn.text = name
//
////                self.editModel?.NativeArea = name
//
//                NVYProfileDataTool.setSingleCondition(info: name, apiName: "NativeArea", completion: { (Bool) in
//
//                })
//
//            }
            
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
                
                let minAge = titles[row1] as! NSString;
                let maxAge = titles[row2] as! NSString;
                NVYProfileDataTool.setSingleCondition(info: "\(titles[row1])岁 \(titles[row2])岁", apiName: "AgeRange", completion: { (Bool) in
                    if Bool {
                        self.editModel?.updateAgeRange(minValue: minAge.integerValue, maxValue: maxAge.integerValue);
                        let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                        cell.selectBtn.text = self.editModel?.ageRangeString();//"\(titles[row1])岁-\(titles[row2])岁"
                    }
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
                let minHeight = titles[row1] as! NSString;
                let maxHeight = titles[row2] as! NSString;
                NVYProfileDataTool.setSingleCondition(info: "\(titles[row1])CM \(titles[row2])CM", apiName: "BodyHeight", completion: { (Bool) in
                    if Bool {
                        let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                        self.editModel?.updateBodyHeightRange(minValue: minHeight.integerValue, maxValue: maxHeight.integerValue);
                        cell.selectBtn.text = self.editModel?.bodyHeightRangeString();//"\(titles[row1])CM-\(titles[row2])CM"
                    }
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
                NVYProfileDataTool.setSingleCondition(info: "\(titles[row1])KG \(titles[row2])KG", apiName: "BodyWeight", completion: { (Bool) in
                    if Bool {
                        let weightMin = titles[row1] as! NSString;
                        let weightMax = titles[row2] as! NSString;
                        self.editModel?.updateBodyWeightRange(minValue: weightMin.integerValue, maxValue: weightMax.integerValue);
                        let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                        cell.selectBtn.text = self.editModel?.bodyWeightRangeString();//"\(titles[row1])KG-\(titles[row2])KG"
                    }
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
                let educationName = titles[row] as? String;
                NVYProfileDataTool.setSingleCondition(info: educationName!, apiName: "Education", completion: { (Bool) in
                    if Bool {
                        let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                        let model = nations[row] as! NVYSysObjModel;
                        self.editModel?.Education = "\(model.Id)";
                        self.editModel?.EducationName = educationName;
                        cell.selectBtn.text = educationName;//titles[row] as? String
                    }
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
                let maritalName = titles[row] as? String;
                NVYProfileDataTool.setSingleCondition(info: maritalName!, apiName: "MaritalStatus", completion: { (Bool) in
                    if Bool {
                        let model = nations[row] as! NVYSysObjModel;
                        let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                        self.editModel?.MaritalStatus = "\(model.Id)";
                        self.editModel?.MaritalStatusName = maritalName;
                        cell.selectBtn.text = maritalName;//titles[row] as? String
                    }
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
                let salaryName = titles[row] as? String;
                NVYProfileDataTool.setSingleCondition(info: salaryName!, apiName: "Salary", completion: { (Bool) in
                    if Bool {
                        let model = nations[row] as! NVYSysObjModel;
                        let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                        self.editModel?.Salary = "\(model.Id)";
                        self.editModel?.SalaryName = salaryName;
                        cell.selectBtn.text = salaryName;//titles[row] as? String
                    }
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
                let houseName = titles[row] as? String;
                NVYProfileDataTool.setSingleCondition(info: houseName!, apiName: "House", completion: { (Bool) in
                    if Bool {
                        let model = nations[row] as! NVYSysObjModel;
                        let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                        self.editModel?.House = "\(model.Id)";
                        self.editModel?.HouseName = houseName;
                        cell.selectBtn.text = houseName;//titles[row] as? String
                    }
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
                let name = titles[row] as? String;
                NVYProfileDataTool.setSingleCondition(info: name!, apiName: "Car", completion: { (Bool) in
                    if Bool {
                        let model = nations[row] as! NVYSysObjModel;
                        let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                        self.editModel?.Car = "\(model.Id)";
                        self.editModel?.CarName = name;
                        cell.selectBtn.text = name;//titles[row] as? String
                    }
                });
            }
        }
        
    }
    
    //MARK: - NVYTextViewCellDelegate
    func finishTVEdit(cell: NVYTextViewCell, text: String) {
        
        NVYProfileDataTool.setSingleCondition(info: text, apiName: "Remark") { (Bool) in
            
        }
    }
    
    func textViewCellBeginEdit(cell: NVYTextViewCell) {
        self.conditionTable?.scrollToRow(at: IndexPath.init(row: 10, section: 0), at: UITableViewScrollPosition.bottom, animated: true);
    }

}
