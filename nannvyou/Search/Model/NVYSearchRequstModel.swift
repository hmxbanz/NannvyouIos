//
//  NVYSearchRequstModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/18.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

class NVYSearchRequstModel: Mappable {

    //各个实例变量
    var pageIndex: Int = 0
    var pageSize: Int = 0
    var sex: Int = 1 // 1-男，2-女
    var marry: Int = 0
    var ageRange: String?
    var area: String?
    
    //必须的方法，用于初始化时就建立映射
    required convenience init?(map: Map) {
        self.init()
    }
    
    //实例变量在JSON中的映射
    func mapping(map: Map) {
        pageIndex   <- map["pageIndex"]
        pageSize    <- map["pageSize"]
        sex         <- map["sex"]
        marry       <- map["marry"]
        ageRange    <- map["ageRange"]
        area        <- map["area"]
    }
}
