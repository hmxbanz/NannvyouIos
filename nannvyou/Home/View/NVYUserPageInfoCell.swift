//
//  NVYUserPageInfoCell.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/13.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

class NVYUserPageInfoCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
