//
//  NVYFriendCell.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/9/12.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

typealias FriendCellDeleBlock = (_ path: NSIndexPath) -> Void

class NVYFriendCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var deleBtn: UIButton!
    
    var cellDeleBlock: FriendCellDeleBlock?
    
    var path: NSIndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userIcon.layer.cornerRadius = 30.0
        userIcon.layer.masksToBounds = true
        
        deleBtn.layer.cornerRadius = 5.0

    }
    
    @IBAction func deleBtnAction(_ sender: UIButton) {
        if (cellDeleBlock != nil) {
            cellDeleBlock!(path!)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
