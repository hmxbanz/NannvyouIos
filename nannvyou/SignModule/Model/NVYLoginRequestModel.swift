//
//  NVYLoginRequestModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/19.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

class NVYLoginRequestModel: Mappable {
    
    var userName: String?
    
    var password: String?
    
    
    required convenience init?(map: Map) {
        self.init()
    }

    
    func mapping(map: Map) {
        userName   <- map["userName"]
        password   <- map["password"]
    }

}
