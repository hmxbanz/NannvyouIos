//
//  NVYDoubleLinePicker.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/8/26.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

typealias DoubleSurePickBlock = (_ row1: NSInteger, _ row2: NSInteger) -> Void

class NVYDoubleLinePicker: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var coverBtn: UIButton!
    
    @IBOutlet weak var picker1: UIPickerView!
    
    @IBOutlet weak var middleLabel: UILabel!
    
    @IBOutlet weak var picker2: UIPickerView!
    
    @IBOutlet weak var lastLabel: UILabel!
    
    var pickerArr: NSMutableArray = []
    
    var currentRow1 = 0
    var currentRow2 = 0

    var surePicker: DoubleSurePickBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        coverBtn.setTitle("", for: .normal)
        
        picker1.delegate   = self
        picker1.dataSource = self
        
        picker2.delegate   = self
        picker2.dataSource = self
    }
    
    func pickerArr(array: NSArray) {
        
        pickerArr = array as! NSMutableArray
        
        picker1.reloadAllComponents()
        picker2.reloadAllComponents()
    }
    
    func lastTitle(title: String) {
        lastLabel.text = title
    }
    
    @IBAction func coverBtnAction(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        self.removeFromSuperview()
    }

    @IBAction func sureBtnAction(_ sender: UIButton) {
        self.removeFromSuperview()

        if (surePicker != nil) {
            surePicker!(currentRow1, currentRow2 + 1)
        }
        
    }
    
    //MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return (pickerArr.count) - 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return pickerArr[row] as? String
        }
        
        return pickerArr[row + 1] as? String
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1 {
            currentRow1 = row
        } else {
            currentRow2 = row
        }

        if currentRow2 < currentRow1 {
            if pickerView.tag == 1 {
                picker2.selectRow(row, inComponent: 0, animated: true)
                currentRow2 = row
            } else {
                picker1.selectRow(row, inComponent: 0, animated: true)
                currentRow1 = row
            }
        } else {
            
        }
        
    }
    
}
