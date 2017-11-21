//
//  NVYPersonInfoVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/3.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

class NVYPersonInfoVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NVYTextFieldCellDelegate, NVYTextViewCellDelegate {

    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    var infoTable: UITableView?
    
    private let cellImages = [#imageLiteral(resourceName: "icon_user"), #imageLiteral(resourceName: "icon_realname"), #imageLiteral(resourceName: "icon_qq"), #imageLiteral(resourceName: "icon_email"), #imageLiteral(resourceName: "icon_info"), #imageLiteral(resourceName: "icon_sex"), #imageLiteral(resourceName: "icon_map"), #imageLiteral(resourceName: "icon_area"), #imageLiteral(resourceName: "icon_birthday"), #imageLiteral(resourceName: "icon_bodyheight"), #imageLiteral(resourceName: "icon_body_weight"), #imageLiteral(resourceName: "icon_occupation"), #imageLiteral(resourceName: "icon_marry"), #imageLiteral(resourceName: "icon_education"), #imageLiteral(resourceName: "icon_salary"), #imageLiteral(resourceName: "icon_hourse"), #imageLiteral(resourceName: "icon_car"), #imageLiteral(resourceName: "icon_nation"),]
    private let cellTitles = ["昵称：", "姓名：", "Q Q：", "邮箱：", "简介：", "性别：", "地区：", "祖籍：", "生日：", "身高：", "体重：", "职业：", "婚史：", "学历：", "月入：", "购房：", "购车：", "民族：",]

    private var userInfoModel: NVYUserEditInfoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        screenHeight = screenFrame.height
        
        navigationItem.title = "个人资料"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveUserInfo))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow_left"), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        view.addSubview(initInfoTable())
        
        userInfoModel = NVYUserModel.getUserModel().transformModel();//NVYUserEditInfoModel()
//        userInfoModel?.Sex = 1;
        
//        NVYProfileDataTool.getUserInfo(completion: { (result) in
//            if result {
//
//            }
//        })
    }
    
    func backAction() {
        
        self.view.endEditing(true)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func initInfoTable() -> UITableView {
        
        if infoTable == nil {
            let frame = CGRect(x: 0.0, y: 0.0, width: screenWidth!, height: screenHeight! - 64.0)
            infoTable = UITableView(frame: frame, style: UITableViewStyle.plain)
            infoTable?.delegate   = self
            infoTable?.dataSource = self
            infoTable?.backgroundColor = UIColor.groupTableViewBackground

//            infoTable?.register(UINib.init(nibName: "NVYSearchCell", bundle: Bundle.main), forCellReuseIdentifier: "searchCell")
            infoTable?.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.01))
        }
        
        return infoTable!
    }
    
    //保存个人信息
    func saveUserInfo() {
        
        print(userInfoModel!)
        
        NVYProfileDataTool.uploadSingleUserInfo(info: "", apiName: "") { (Bool) in
            
        }
    }
    
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 18
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 4 {
            return 100
        }
        
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row < 4 {
            
            let cell = Bundle.main.loadNibNamed("NVYTextFieldCell", owner: nil, options: nil)?.first as? NVYTextFieldCell
            
            let img = UIImage.wz_changeImageTintColor(tintColor: UIColor.wz_colorWithHexString(hex: "#ff7da8"), image: cellImages[indexPath.row])
            cell?.iconView?.image = img
            cell?.delegate = self
            cell?.path = indexPath as NSIndexPath
            
            cell?.titleLabel?.text = cellTitles[indexPath.row]
            
            switch indexPath.row {
            case 0:
                cell?.textField.text = userInfoModel?.NickName
                break
               
            case 1:
                cell?.textField.text = userInfoModel?.RealName
                break
                
            case 2:
                cell?.textField.text = userInfoModel?.QQ
                break
                
            default:
                cell?.textField.text = userInfoModel?.Email
                break
            }
            
            return cell!
        } else if indexPath.row == 4 {
            
            let cell = Bundle.main.loadNibNamed("NVYTextViewCell", owner: nil, options: nil)?.first as? NVYTextViewCell
            cell?.delegate = self
            let img = UIImage.wz_changeImageTintColor(tintColor: UIColor.wz_colorWithHexString(hex: "#ff7da8"), image: cellImages[indexPath.row])
            cell?.iconView?.image = img
            
            cell?.titleLabel?.text = cellTitles[indexPath.row]
            
            cell?.textView.text = userInfoModel?.SelfDescribe
            
            return cell!
            
        } else if indexPath.row == 5 {
            
            let cell = Bundle.main.loadNibNamed("NVYSexCell", owner: nil, options: nil)?.first as? NVYSexCell
            
            let img = UIImage.wz_changeImageTintColor(tintColor: UIColor.wz_colorWithHexString(hex: "#ff7da8"), image: cellImages[indexPath.row])
            cell?.iconView?.image = img
            
            cell?.titleLabel?.text = cellTitles[indexPath.row]
            
            cell?.sexBlock = { (_ tag: Int) -> Void in

                if tag == 0 {
                    self.userInfoModel?.Sex = 1
                    
                    NVYProfileDataTool.uploadSingleUserInfo(info: true, apiName: "Sex", completion: { (Bool) in
                        
                    })
                } else {
                    self.userInfoModel?.Sex = 0
                    
                    NVYProfileDataTool.uploadSingleUserInfo(info: false, apiName: "Sex", completion: { (Bool) in
                        
                    })
                }                
            }
            
            return cell!
            
        } else {
           
            let cell = Bundle.main.loadNibNamed("NVYPickerCell", owner: nil, options: nil)?.first as? NVYPickerCell
            
            let img = UIImage.wz_changeImageTintColor(tintColor: UIColor.wz_colorWithHexString(hex: "#ff7da8"), image: cellImages[indexPath.row])
            cell?.iconView?.image = img
            
            cell?.titleLabel?.text = cellTitles[indexPath.row]
            
            switch indexPath.row {
            case 6:
                cell?.selectBtn.text = userInfoModel?.Area ?? "请选择"
                break
                
            case 7:
                cell?.selectBtn.text = userInfoModel?.NativeArea ?? "请选择"
                break
                
            case 8:
                cell?.selectBtn.text = userInfoModel?.Birthday ?? "请选择"
                break
                
            case 9:
                cell?.selectBtn.text = userInfoModel?.BodyHeight ?? "请选择"
                break
                
            case 10:
                cell?.selectBtn.text = userInfoModel?.BodyWeight ?? "请选择"
                break
                
            case 11:
                cell?.selectBtn.text = userInfoModel?.Occupation ?? "请选择"
                break
                
            case 12:
                cell?.selectBtn.text = userInfoModel?.MaritalStatus ?? "请选择"
                break
                
            case 13:
                cell?.selectBtn.text = userInfoModel?.Education ?? "请选择"
                break
                
            case 14:
                cell?.selectBtn.text = userInfoModel?.Salary ?? "请选择"
                break
                
            case 15:
                cell?.selectBtn.text = userInfoModel?.House ?? "请选择"
                break
                
            case 16:
                cell?.selectBtn.text = userInfoModel?.Car ?? "请选择"
                break
                
            default:
                cell?.selectBtn.text = userInfoModel?.Nation ?? "请选择"
                break
            }
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 6 || indexPath.row == 7 {
            
            let addressPicker: NVYAddressPicker = Bundle.main.loadNibNamed("NVYAddressPicker", owner: nil, options: nil)?.first as! NVYAddressPicker
            addressPicker.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49)
            
            addressPicker.show(view: self.view, components: 3)
            
            addressPicker.surePick = { (name, ID) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                
                cell.selectBtn.text = name
                
                if indexPath.row == 6 {
                    self.userInfoModel?.Area = name
                    
                    NVYProfileDataTool.uploadSingleUserInfo(info: name, apiName: "Area", completion: { (Bool) in
                        
                    })
                    
                } else {
                    self.userInfoModel?.NativeArea = name
                    
                    NVYProfileDataTool.uploadSingleUserInfo(info: name, apiName: "NativeArea", completion: { (Bool) in
                        
                    })
                }
                
            }
        } else if (indexPath.row == 8) {//生日
            
            let timePicker: NVYTimePicker = Bundle.main.loadNibNamed("NVYTimePicker", owner: nil, options: nil)?.first as! NVYTimePicker
            timePicker.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49)
            timePicker.timePicker.datePickerMode = .date
            view.addSubview(timePicker)
            
            timePicker.sureBlock = { (_ date: Date) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                
                //时间转化
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateStr = dateFormat.string(from: date)
                
                cell.selectBtn.text = dateStr

                NVYProfileDataTool.uploadSingleUserInfo(info: dateStr, apiName: "Birthday", completion: { (Bool) in
                    
                })
            }
            
        } else if (indexPath.row == 9) {//身高
            
            let picker = Bundle.main.loadNibNamed("NVYSingleLinePicker", owner: nil, options: nil)?.first as? NVYSingleLinePicker
            picker?.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49)
            self.view.addSubview(picker!)
            
            let titles = NSMutableArray()
            
            for i in 0...80 {
                titles.add("\(i + 140)")
            }
            
            picker?.pickerArr(array: titles)
            
            picker?.surePick = { (_ row: NSInteger) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                
                cell.selectBtn.text = titles[row] as? String
                    
//                self.userInfoModel?.BodyHeight = titles[row] as? String
                
                NVYProfileDataTool.uploadSingleUserInfo(info: cell.selectBtn.text!, apiName: "BodyHeight", completion: { (Bool) in
                    
                })
            }
            
        } else if (indexPath.row == 10) {//体重
            
            let picker = Bundle.main.loadNibNamed("NVYSingleLinePicker", owner: nil, options: nil)?.first as? NVYSingleLinePicker
            picker?.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49)
            self.view.addSubview(picker!)
            
            let titles = NSMutableArray()
            
            for i in 0...100 {
                titles.add("\(i + 30)")
            }
            
            picker?.pickerArr(array: titles)
            
            picker?.surePick = { (_ row: NSInteger) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                
                
                cell.selectBtn.text = titles[row] as? String
                    
//                self.userInfoModel?.BodyWeight = titles[row] as? String
                
                NVYProfileDataTool.uploadSingleUserInfo(info: cell.selectBtn.text!, apiName: "BodyWeight", completion: { (Bool) in
                    
                })
            }
            
        } else if (indexPath.row == 11) {//职业
            
            let picker = Bundle.main.loadNibNamed("NVYSingleLinePicker", owner: nil, options: nil)?.first as? NVYSingleLinePicker
            picker?.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49)
            self.view.addSubview(picker!)
            
            let nations = NVYProfileDataTool().getJob()
            
            let titles = NSMutableArray()
            
            for item in nations {
                let model = item as! NVYSysObjModel
                titles.add(model.Name!)
            }
            
            picker?.pickerArr(array: titles)
            
            picker?.surePick = { (_ row: NSInteger) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                
                cell.selectBtn.text = titles[row] as? String
                    
//                self.userInfoModel?.Occupation = titles[row] as? String
                
                NVYProfileDataTool.uploadSingleUserInfo(info: cell.selectBtn.text!, apiName: "Occupation", completion: { (Bool) in
                    
                })
            }
            
        } else if (indexPath.row == 12) {//婚史
            
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
                
//                self.userInfoModel?.MaritalStatus = titles[row] as? String
                
                NVYProfileDataTool.uploadSingleUserInfo(info: cell.selectBtn.text!, apiName: "MaritalStatus", completion: { (Bool) in
                    
                })
            }
            
        } else if (indexPath.row == 13) {//学历
            
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
                
//                self.userInfoModel?.Education = titles[row] as? String
                
                NVYProfileDataTool.uploadSingleUserInfo(info: cell.selectBtn.text!, apiName: "Education", completion: { (Bool) in
                    
                })
            }
            
        } else if (indexPath.row == 14) {//月入

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
                
//                self.userInfoModel?.Salary = titles[row] as? String
                
                NVYProfileDataTool.uploadSingleUserInfo(info: cell.selectBtn.text!, apiName: "Salary", completion: { (Bool) in
                    
                })
            }
            
        } else if (indexPath.row == 15) {//购房

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
                
//                self.userInfoModel?.House = titles[row] as? String
                
                NVYProfileDataTool.uploadSingleUserInfo(info: cell.selectBtn.text!, apiName: "House", completion: { (Bool) in
                    
                })
            }
            
        } else if (indexPath.row == 16) {//购车
            
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
                
//                self.userInfoModel?.Car = titles[row] as? String
                
                NVYProfileDataTool.uploadSingleUserInfo(info: cell.selectBtn.text!, apiName: "Car", completion: { (Bool) in
                    
                })
            }
            
        } else {//民族
            
            let picker = Bundle.main.loadNibNamed("NVYSingleLinePicker", owner: nil, options: nil)?.first as? NVYSingleLinePicker
            picker?.frame = CGRect(x: 0, y: 0, width: self.screenWidth!, height: self.screenHeight! - 49)
            self.view.addSubview(picker!)
            
            let nations = NVYProfileDataTool().getNation()
            
            let titles = NSMutableArray()
            
            for item in nations {
                let model = item as! NVYSysObjModel
                titles.add(model.Name!)
            }
            
            picker?.pickerArr(array: titles)
            
            picker?.surePick = { (_ row: NSInteger) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath) as! NVYPickerCell
                
                cell.selectBtn.text = titles[row] as? String
                
//                self.userInfoModel?.Nation = titles[row] as? String
                
                NVYProfileDataTool.uploadSingleUserInfo(info: cell.selectBtn.text!, apiName: "Nation", completion: { (Bool) in
                    
                })
            }
        }
    }
    
    //MARK: - NVYTextFieldCellDelegate
    func finishTFEdit(cell: NVYTextFieldCell, text: String, path: NSIndexPath) {
        switch path.row {
        case 0:
//            userInfoModel?.NickName = text
            NVYProfileDataTool.uploadSingleUserInfo(info: text, apiName: "NickName", completion: { (Bool) in
                
            })
            break
            
        case 1:
//            userInfoModel?.RealName = text
            NVYProfileDataTool.uploadSingleUserInfo(info: text, apiName: "RealName", completion: { (Bool) in
                
            })
            break

        case 2:
//            userInfoModel?.QQ = text
            NVYProfileDataTool.uploadSingleUserInfo(info: text, apiName: "QQ", completion: { (Bool) in
                
            })
            break

        default:
//            userInfoModel?.Email = text
            NVYProfileDataTool.uploadSingleUserInfo(info: text, apiName: "Email", completion: { (Bool) in
                
            })
            break
        }
    }
    
    //MARK: - NVYTextViewCellDelegate
    func finishTVEdit(cell: NVYTextViewCell, text: String) {
        userInfoModel?.SelfDescribe = text
        
        NVYProfileDataTool.uploadSingleUserInfo(info: text, apiName: "SelfDescribe") { (Bool) in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
