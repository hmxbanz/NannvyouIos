//
//  NVYUserEditConditionModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/8/8.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

class NVYUserEditConditionModel: NSObject, Mappable {

    var AgeRange: String?
    
    var BodyHeight: String?
    
    var BodyWeight: String?
    
    var Area: String?
    //广东 汕头 金平区
    var NativeArea: String?
    //未婚
    var MaritalStatus: String?
    
    var Education: String?
    //10000-20000
    var Salary: String?
    //已购房
    var House: String?
    //已购车
    var Car: String?
    
    var Remark: String?
    
    required convenience init?(map: Map) {
        self.init()
        
    }
    
    func mapping(map: Map) {
        AgeRange       <- map["AgeRange"]
        BodyHeight     <- map["BodyHeight"]
        BodyWeight     <- map["BodyWeight"]
        Area           <- map["Area"]
        NativeArea     <- map["NativeArea"]
        MaritalStatus  <- map["MaritalStatus"]
        Education      <- map["Education"]
        Salary         <- map["Salary"]
        House          <- map["House"]
        Car            <- map["Car"]
        Remark         <- map["Remark"]
    }

}
