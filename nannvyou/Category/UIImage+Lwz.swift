//
//  UIImage+Lwz.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/28.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

extension UIImage {
    
    
    class func wz_changeImageTintColor(tintColor: UIColor, image: UIImage) -> UIImage {

        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let context = UIGraphicsGetCurrentContext()
        context!.translateBy(x: 0, y: image.size.height);
        context!.scaleBy(x: 1.0, y: -1.0);
        context!.setBlendMode(CGBlendMode.normal);
        let rect = CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height)
        context!.clip(to: rect, mask: image.cgImage!);
        tintColor.setFill()
        context!.fill(rect);

        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImg!
        
    }
    
}
