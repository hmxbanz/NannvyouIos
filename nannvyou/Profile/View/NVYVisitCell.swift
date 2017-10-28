//
//  NVYVisitCell.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/8/31.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

class NVYVisitCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userIcon.layer.cornerRadius = 20.0
        userIcon.layer.masksToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
