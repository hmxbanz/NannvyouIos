//
//  NVYUnloadHead.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/9.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

typealias LoginBlock = () -> Void

class NVYUnloadHead: UIView {

    @IBOutlet weak var bgImgView: UIImageView!
    
    @IBOutlet weak var unloadBtn: UIButton!
    
    var loginEvent: LoginBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        unloadBtn.layer.cornerRadius = 15.0
        
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        if loginEvent != nil {
            loginEvent!()
        }
    }

}
