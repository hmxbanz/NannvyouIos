//
//  NVYUserEditInfoModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/8/7.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

class NVYUserEditInfoModel: NSObject, Mappable {

    var NickName: String?

    var RealName: String?

    var QQ: String?
    
    var Email: String?
    //个人的简介
    var SelfDescribe: String?
    //true
    var Sex: Int = 0
    //1990-11-1
    var Birthday: String?
    
    var BodyHeight: String?

    var BodyWeight: String?
    //IT行业 软件工程师
    var Occupation: String?
    //广东 汕头 金平区
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
    //汉族
    var Nation: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        NickName   <- map["NickName"]
        RealName   <- map["RealName"]
        QQ         <- map["QQ"]
        Email      <- map["Email"]
        SelfDescribe   <- map["SelfDescribe"]
        Sex            <- map["Sex"]
        Birthday       <- map["Birthday"]
        BodyHeight     <- map["BodyHeight"]
        BodyWeight     <- map["BodyWeight"]
        Occupation     <- map["Occupation"]
        Area           <- map["Area"]
        NativeArea     <- map["NativeArea"]
        MaritalStatus  <- map["MaritalStatus"]
        Education      <- map["Education"]
        Salary         <- map["Salary"]
        House          <- map["House"]
        Car            <- map["Car"]
        Nation         <- map["Nation"]
    }
    
}
