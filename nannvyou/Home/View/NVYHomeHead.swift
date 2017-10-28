//
//  NVYHomeHead.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/5/29.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

typealias HomeNewBlock = () -> Void
typealias HomeHotBlock = () -> Void
typealias HomeRandonBlock = () -> Void
typealias HomeDynamicBlock = () -> Void

class NVYHomeHead: UICollectionReusableView {
    
    @IBOutlet weak var cycleView: UIView!

    @IBOutlet weak var mostNew: UIButton!
    
    @IBOutlet weak var mostHit: UIButton!
    
    @IBOutlet weak var randon: UIButton!
    
    @IBOutlet weak var dynamic: UIButton!
    
    var homeNewAction: HomeNewBlock?
    var homeHotAction: HomeHotBlock?
    var homeRandonAction: HomeRandonBlock?
    var homeDynamicAction: HomeDynamicBlock?
    
    @IBAction func mostNewAction(_ sender: UIButton) {//最新
        
        if (homeNewAction != nil) {
            homeNewAction!()
        }
    }
    
    @IBAction func mostHitAction(_ sender: UIButton) {//最热
        
        if (homeHotAction != nil) {
            homeHotAction!()
        }
    }
    
    @IBAction func randonAction(_ sender: UIButton) {//随机
        
        if (homeRandonAction != nil) {
            homeRandonAction!()
        }
    }
    
    @IBAction func dynamicAction(_ sender: UIButton) {//动态
        
        if (homeDynamicAction != nil) {
            homeDynamicAction!()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let frame = cycleView.bounds
        let localImages = ["guide_pic_01", "guide_pic_02", "guide_pic_03"]
        let cycleScrollView = WRCycleScrollView(frame:frame, type:.LOCAL, imgs:localImages, descs:nil)
//        cycleScrollView.delegate = self as! WRCycleScrollViewDelegate
        cycleScrollView.descLabelFont = UIFont.boldSystemFont(ofSize: 15)
        cycleScrollView.descLabelHeight = 50
        cycleScrollView.pageControlAliment = .CenterBottom
        cycleView.addSubview(cycleScrollView)
    }
    
}
