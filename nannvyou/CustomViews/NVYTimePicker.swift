//
//  NVYTimePicker.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/8/23.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

typealias TimeSurePickBlock = (_ Date: Date) -> Void

class NVYTimePicker: UIView {

    @IBOutlet weak var coverBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var sureBtn: UIButton!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    var sureBlock: TimeSurePickBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        coverBtn.setTitle("", for: .normal)
    }
    
    override func layoutSubviews() {
        
        
    }
    
    
    @IBAction func coverBtnAction(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    @IBAction func sureBtnAction(_ sender: UIButton) {
        self.removeFromSuperview()

        if (sureBlock != nil) {
            sureBlock!(timePicker.date)
        }
    }
    
    @IBAction func timeChange(_ sender: UIDatePicker) {
        
    }

}
