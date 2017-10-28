//
//  NVYVerticalButton.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/5/29.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

class NVYVerticalButton: UIButton {

    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        
        let imgWidth  = currentImage?.size.width
        let imgHeight = currentImage?.size.height
        
        let imgX = (frame.size.width - imgWidth!)/2.0
        let imgY = (frame.size.height * 0.6 - imgHeight!)/2.0
        
        return CGRect(x: imgX, y: imgY, width: imgWidth!, height: imgHeight!)
    }

    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
                
        let titleY      = frame.size.height * 0.6
        let titleWidth  = frame.size.width
        let titleHeight = frame.size.height * 0.4
        
        return CGRect(x: 0.0, y: titleY, width: titleWidth, height: titleHeight)
    }
}
