//
//  NVYCustomSwitch.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/4.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

//没有效果，只能以后来研究


import UIKit

class NVYCustomSwitch: UISwitch {

    var title = "88iu"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    func create(imgTitle: String) {

        title = imgTitle
        
        let img = initTitle()
        
        self.onImage = img
        self.offImage = img

    }
    
    
    func initTitle() -> UIImage {
        
        let img = creatImageWithColor(color: UIColor.blue)
        
        let textAttributes = [NSForegroundColorAttributeName:UIColor.white,
                              NSFontAttributeName:UIFont.systemFont(ofSize: 13.0),
                              NSBackgroundColorAttributeName:UIColor.blue] as [String : Any]
        let textSize = NSString(string: title).size(attributes: textAttributes)
        let textFrame = CGRect(x: 0.0, y: 0.0, width: textSize.width, height: textSize.height)
        
        let imageSize = img.size
        
        // 开始给图片添加文字水印
        UIGraphicsBeginImageContext(imageSize)
        img.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        NSString(string: title).draw(in: textFrame, withAttributes: textAttributes)
        
        let waterMarkedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return waterMarkedImage!
    
    }
    
    func creatImageWithColor(color:UIColor) -> UIImage{
        let rect = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 20.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

}
