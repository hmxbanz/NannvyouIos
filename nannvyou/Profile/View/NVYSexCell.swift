//
//  NVYSexCell.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/6.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

typealias SexButtonBlock = (_ tag: Int) -> Void

class NVYSexCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var maleBtn: UIButton!
    
    @IBOutlet weak var femaleBtn: UIButton!
    
    var currentBtn: UIButton!
    
    var sexBlock: SexButtonBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        maleBtn.isSelected = true
        currentBtn = maleBtn
        
    }

    @IBAction func maleBtnAction(_ sender: UIButton) {
        
        if currentBtn == sender {
            return
        } else {
            currentBtn.isSelected = false
            currentBtn = sender
            currentBtn.isSelected = true
        }
        
        if sexBlock != nil {
            sexBlock!(sender.tag)
        }
    }
    
    @IBAction func femaleBtnAction(_ sender: UIButton) {
        
        if currentBtn == sender {
            return
        } else {
            currentBtn.isSelected = false
            currentBtn = sender
            currentBtn.isSelected = true
        }
        
        if sexBlock != nil {
            sexBlock!(sender.tag)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
