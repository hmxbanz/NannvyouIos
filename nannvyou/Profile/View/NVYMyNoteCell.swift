//
//  NVYMyNoteCell.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/9/12.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

typealias NoteCellAgreeBlock = (_ path: NSIndexPath) -> Void

class NVYMyNoteCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var agreeBtn: UIButton!
    
    var path: NSIndexPath?
    
    var agreeBlock: NoteCellAgreeBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userIcon.layer.cornerRadius = 30.0
        userIcon.layer.masksToBounds = true
        
        agreeBtn.layer.cornerRadius = 5.0
    }
    
    @IBAction func agreeAction(_ sender: UIButton) {
        
        if agreeBlock != nil {
            agreeBlock?(path!)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
