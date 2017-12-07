//
//  NVYSexCell.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/6.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

typealias SexButtonBlock = (_ tag: Int) -> Bool

class NVYSexCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var maleBtn: UIButton!
    
    @IBOutlet weak var femaleBtn: UIButton!
    
    var currentBtn: UIButton!
    
    var sexBlock: SexButtonBlock?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

//        maleBtn.isSelected = true
//        currentBtn = maleBtn
        
    }
    
    //-1：未选择  0-女，1-男
    func refreshSex(sex:Int) -> Void {
        let female = (sex == 0);
        let male = (sex == 1);
        maleBtn.isSelected = male;
        femaleBtn.isSelected = female;
        if female {
            currentBtn = femaleBtn;
        }else if (male){
            currentBtn = maleBtn;
        }else{
            currentBtn = nil;
        }
    }

    @IBAction func maleBtnAction(_ sender: UIButton) {
        
        if currentBtn == sender {
            return
        } else {
            if sexBlock != nil {
                let canChange = sexBlock!(sender.tag);
                if canChange {
                    currentBtn.isSelected = false
                    currentBtn = sender
                    currentBtn.isSelected = true
                }
            }
        }
    }
    
    @IBAction func femaleBtnAction(_ sender: UIButton) {
        
        if currentBtn == sender {
            return
        } else {
            if sexBlock != nil {
               let canChange = sexBlock!(sender.tag);
                if canChange {
                    currentBtn.isSelected = false
                    currentBtn = sender
                    currentBtn.isSelected = true
                }
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
