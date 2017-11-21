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
        let normalImg = UIImage.nvy_getImageWithColor(color: UIColor.wz_colorWithHexString(hex: "FF87D6"));
        let unableImg = UIImage.nvy_getImageWithColor(color: UIColor.wz_colorWithHexString(hex: "B8B8B8"));
        agreeBtn.setBackgroundImage(normalImg, for: .normal);
        agreeBtn.setBackgroundImage(unableImg, for: .disabled);
        agreeBtn.layer.cornerRadius = 5.0
        agreeBtn.clipsToBounds = true;
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
