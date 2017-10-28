//
//  NVYSwitchCell.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/26.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

typealias SwitchCellBlock = (_ path: NSIndexPath, _ status: Bool) -> Void

class NVYSwitchCell: UITableViewCell {

    @IBOutlet weak var cellImgView: UIImageView!
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    @IBOutlet weak var cellSwitch: UISwitch!
    
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    
    var path: NSIndexPath?
    
    var switchBlock: SwitchCellBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        if cellImgView.image == nil {
            imgWidth.constant = 0.001
        }
    }
    
    @IBAction func cellSwitchAction(_ sender: UISwitch) {
        
        if switchBlock != nil {
            switchBlock!(path!, sender.isOn)
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
