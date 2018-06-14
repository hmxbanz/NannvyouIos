//
//  NVYDynamicDetailVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/8/21.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import Kingfisher

class NVYDynamicDetailVC: UIViewController {

    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
        
    var detailModel: NVYHomeCellModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        screenHeight = screenFrame.height
        
        navigationItem.title = "动态详情"
        
        view.backgroundColor = UIColor.white
        
        setupViews()
    }
    
    func setupViews() {
        
        //scrollView
        let scrollContainer = UIScrollView(frame: view.bounds)
        view.addSubview(scrollContainer)
        
        //top view
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth!, height: 70))
        scrollContainer.addSubview(topView)
        
        let userIcon = UIButton(frame: CGRect(x: 20, y: 10, width: 50, height: 50))
        userIcon.layer.cornerRadius = 25
        userIcon.layer.masksToBounds = true
        // UIImageView
        let imgStr = "\(kBaseURL)\(detailModel?.IconSmall ?? "")"
        let imgURL = NSURL(string: imgStr)
        let imgResource = ImageResource(downloadURL: imgURL! as URL, cacheKey: imgStr)
        userIcon.kf.setImage(with: imgResource, for: .normal)
        //setImage(with: imgResource, placeholder: Image(named: "icon_head"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in
            
        //})
        userIcon.layer.cornerRadius = 25.0
        userIcon.layer.masksToBounds = true
        scrollContainer.addSubview(userIcon)
        
        userIcon.addTarget(self, action: #selector(iconAction), for: .touchUpInside)

        let nameLabel = UILabel(frame: CGRect(x: userIcon.frame.maxX + 10.0, y: 10, width: 200, height: 25))
        nameLabel.text = detailModel?.NickName
        topView.addSubview(nameLabel)
        
        let timeLabel = UILabel(frame: CGRect(x: userIcon.frame.maxX + 10.0, y: 35, width: 200, height: 25))
        timeLabel.text = detailModel?.CreateDate?.lwz_changeTime()
        timeLabel.font = UIFont.systemFont(ofSize: 13.0)
        topView.addSubview(timeLabel)
        
        let line = UILabel(frame: CGRect(x: 0, y: 69.5, width: screenWidth!, height: 0.5))
        line.backgroundColor = UIColor.groupTableViewBackground
        topView.addSubview(line)
        
        //detail content
//        let options : NSStringDrawingOptions = .usesFontLeading

//        let str = detailModel?.Content as! NSString
        
//        let contentSize = str.boundingRect(with: CGSize(width: screenWidth!, height: screenHeight!), options: options, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 16.0)], context: nil).size
        let contentLabel = UILabel(frame: CGRect(x: 10, y: topView.frame.maxY, width: screenWidth! - 20, height: 100))
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        contentLabel.text = detailModel?.Content
        scrollContainer.addSubview(contentLabel)
        
        //image
        let imgDict = detailModel?.LifePhotoes?.firstObject as? NSDictionary
        let imgStr1 = "\(kBaseURL)\(imgDict?["Photo"] ?? "")";//(imgDict?["PhotoSmall"] ?? "")"
        let imgURL1 = NSURL(string: imgStr1)
        let imgResource1 = ImageResource(downloadURL: imgURL1! as URL, cacheKey: imgStr1)
        let imgView = UIImageView(frame: CGRect(x: 0, y: contentLabel.frame.maxY, width: screenWidth!, height: screenHeight!))
        imgView.kf.setImage(with: imgResource1, placeholder: nil, options: nil, progressBlock: nil) { (Image, NSError, CacheType, URL) in
            
            if Image != nil {
                let imgWidth = self.screenWidth! - 20;
                let imgHeight = imgWidth * (Image?.size.height)! / (Image?.size.width)!
                
                imgView.frame = CGRect(x: 10, y: contentLabel.frame.maxY, width: imgWidth, height: imgHeight)
                
                scrollContainer.addSubview(imgView)
                
                scrollContainer.contentSize = CGSize(width: self.screenWidth!, height: imgView.frame.maxY + 200)
            }

        }
    }
    
    func iconAction() {
        let vc = NVYUserPageVC()
        vc.userInfoID = (detailModel?.UserInfoID)!
        navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    

}
