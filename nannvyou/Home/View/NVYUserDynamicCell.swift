//
//  NVYUserDynamicCell.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/8/15.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import Kingfisher

class NVYUserDynamicCell: UITableViewCell {
    
    @IBOutlet weak var userIcon: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
//    var model: NVYHomeCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        userIcon.layer.cornerRadius = 20.0
        userIcon.layer.masksToBounds = true
    }
    
    var model: NVYHomeCellModel? {

        set {
            
            let imgStr = "\(kBaseURL)\(newValue?.IconSmall ?? "")"
            let imgURL = NSURL(string: imgStr)
            let imgResource = ImageResource(downloadURL: imgURL! as URL, cacheKey: imgStr)
            userIcon?.kf.setImage(with: imgResource, placeholder: Image(named: "icon_head"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in
                
            })
            
            nameLabel.text = newValue?.NickName
            contentLabel.text = newValue?.Content
            
            let imgDict = newValue?.LifePhotoes?.firstObject as? NSDictionary
            let imgStr1 = "\(kBaseURL)\(imgDict?["PhotoSmall"] ?? "")"
            let imgURL1 = NSURL(string: imgStr1)
            let imgResource1 = ImageResource(downloadURL: imgURL1! as URL, cacheKey: imgStr1)
            photoView?.kf.setImage(with: imgResource1, placeholder: Image(named: "icon_head"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in
                
            })
            
            timeLabel.text = newValue?.CreateDate?.lwz_changeTime()
        }
        get {
            return self.model
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
