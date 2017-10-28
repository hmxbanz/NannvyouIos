//
//  NVYShowBigImageView.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/9/20.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

class NVYShowBigImageView: UIView {
    
    var imgView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imgView = UIImageView(frame: self.bounds)
        self.addSubview(imgView!)
        imgView?.isUserInteractionEnabled = true
    }
    
    func showBigImage(image: UIImage) {
        imgView?.image = image
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
}
