//
//  NVYMainHomeHead.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/8/14.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

typealias MainHomeNewBlock = () -> Void
typealias MainHomeHotBlock = () -> Void
typealias MainHomeRandonBlock = () -> Void
typealias MainHomeDynamicBlock = () -> Void

class NVYMainHomeHead: UIView {

    var screenWidth: CGFloat?

    @IBOutlet weak var cycleView: UIView!
    
    @IBOutlet weak var mostNew: UIButton!
    
    @IBOutlet weak var mostHit: UIButton!
    
    @IBOutlet weak var randon: UIButton!
    
    @IBOutlet weak var dynamic: UIButton!
    
    let cycleScrollView = WRCycleScrollView.init(frame: CGRect.zero);
    
    var homeNewAction: MainHomeNewBlock?
    var homeHotAction: MainHomeHotBlock?
    var homeRandonAction: MainHomeRandonBlock?
    var homeDynamicAction: MainHomeDynamicBlock?
    
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
        
        mostNew.titleLabel?.textAlignment = NSTextAlignment.center
        let mostNewImg = UIImage.wz_changeImageTintColor(tintColor: UIColor.wz_colorWithHexString(hex: "#ff7da8"), image: #imageLiteral(resourceName: "nav_new"))
        mostNew.setImage(mostNewImg, for: .normal)
        
        mostHit.titleLabel?.textAlignment = NSTextAlignment.center
        let mostHitImg = UIImage.wz_changeImageTintColor(tintColor: UIColor.wz_colorWithHexString(hex: "#ff7da8"), image: #imageLiteral(resourceName: "nav_hot"))
        mostHit.setImage(mostHitImg, for: .normal)
        
        dynamic.titleLabel?.textAlignment = NSTextAlignment.center
        let dynamicImg = UIImage.wz_changeImageTintColor(tintColor: UIColor.wz_colorWithHexString(hex: "#ff7da8"), image: #imageLiteral(resourceName: "nav_share"))
        dynamic.setImage(dynamicImg, for: .normal)
        
        cycleScrollView.descLabelFont = UIFont.boldSystemFont(ofSize: 15)
        cycleScrollView.descLabelHeight = 50
        cycleScrollView.pageControlAliment = .CenterBottom
        cycleScrollView.imgsType = .SERVER;
        cycleView.addSubview(cycleScrollView);
        
        let localImages = ["http://oss.nannvyou.cn/Images/AD/banner1.jpg",
                           "http://oss.nannvyou.cn/Images/AD/banner2.jpg",
                           "http://oss.nannvyou.cn/Images/AD/banner3.jpg"]
        cycleScrollView.serverImgArray = localImages;
        NVYHomeDataTool.getADLists { (List) in
            var serverList: [String]? = [];
            if let tmpList = List{
                for info in tmpList {
                    var value = info["RemoteADPhoto"] as? String;
                    if value == nil {
                        value = "\(kBaseURL)\(info["ADPhoto"] ?? "")";
                    }
                    serverList?.append(value ?? "");
                }
            }
            self.refreshADImage(imgList: serverList);
        };
    }
    
    func refreshADImage(imgList: [String]?) -> Void {
        if (imgList != nil && imgList!.count > 0) {
            cycleScrollView.serverImgArray = imgList;
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        
        //放错图片，导致调试了一个晚上，效果都不好。
        //但是移位64的问题就是真的存在的。
        let frame = CGRect(x: 0, y: 0, width: screenWidth!, height: cycleView.bounds.height)
        cycleScrollView.frame = frame;
    }
}
