//
//  NVYSingleLinePicker.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/15.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

typealias SingleSurePickBlock = (_ row: NSInteger) -> Void

class NVYSingleLinePicker: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var sureButton: UIButton!
    
    @IBOutlet weak var singlePicker: UIPickerView!
    
//    open var pickerArr: Array<Any> = []
    var pickerArr: NSMutableArray = []
    
    var surePick: SingleSurePickBlock?
    
    var currentRow = 0
    
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

        if (surePick != nil) {
            surePick!(currentRow)
        }
    }
    
    func pickerArr(array: NSArray) {
        
        pickerArr = array.mutableCopy() as! NSMutableArray
        
        singlePicker.reloadAllComponents()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeFromSuperview()
    }

}

extension NVYSingleLinePicker {
    
    //MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerArr.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerArr[row] as? String
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        currentRow = row
    }
    
}
