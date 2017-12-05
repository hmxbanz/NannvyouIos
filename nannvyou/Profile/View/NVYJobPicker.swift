//
//  NVYJobPicker.swift
//  nannvyou
//
//  Created by Danplin on 2017/12/4.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

typealias NVYJobConfirmBlock = (_ main: NVYSysObjModel?, _ sub: NVYSysObjModel?) -> Void

class NVYJobPicker: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var sureButton: UIButton!
    
    @IBOutlet weak var singlePicker: UIPickerView!
    
    var datas:[NVYSysObjModel]? = nil;
    var confirmBlock: NVYJobConfirmBlock?
    
    var row1: NSInteger = 0, row2: NSInteger = 0;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        singlePicker.delegate = self
        singlePicker.dataSource = self
    }
    
    
    @IBAction func cancelAction(_ sender: UIButton) {
        removeFromSuperview()
    }
    
    @IBAction func sureAction(_ sender: UIButton) {
        removeFromSuperview()
        if (confirmBlock != nil) {
            let mainObj = datas?[row1];
            let subInfo = mainObj?.ChildDictionaries?[row2] as? NSDictionary;
            let subObj = Mapper<NVYSysObjModel>().map(JSONObject: subInfo);
            confirmBlock!(mainObj, subObj);
        }
    }
    
    func refreshPickerData(list: [NVYSysObjModel]?) -> Void {
        datas?.removeAll();
        if list != nil {
            datas = (datas ?? []) + list!;
        }
        singlePicker.reloadAllComponents();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeFromSuperview()
    }
}

extension NVYJobPicker {
    
    //MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40;
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 1 {
            let curObj = datas?[row1];
            let count = curObj?.ChildDictionaries?.count ?? 0;
            return count;
        }
        return datas?.count ?? 0;
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 1 {
            let mainObj = datas?[row1];
            let subObj = mainObj?.ChildDictionaries?.object(at: row) as? [String: Any];
            let name = subObj?["Name"] as? String;
            return name;
        }
        let obj = datas?[row];
        return obj?.Name;
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let mainRow = (component == 0);
        if mainRow {
            if row1 != row {
                row1 = row;
                row2 = 0;
                pickerView.reloadComponent(1);
                pickerView.selectRow(0, inComponent: 1, animated: true);
            }
        }else{
            row2 = row;
        }
    }
    
}
