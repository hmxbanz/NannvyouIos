//
//  NVYPickerCell.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/6.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

class NVYPickerCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var selectBtn: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
