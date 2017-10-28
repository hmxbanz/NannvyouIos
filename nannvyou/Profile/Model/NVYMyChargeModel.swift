//
//  NVYMyChargeModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/9/1.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

class NVYMyChargeModel: Mappable {

//    var Age: Int = 0
//    var CellPhone: String?
    var CreateDate: String?
//    var EducationName: String?
//    var NativeAreaName: String?
//    var NativeCityName = "\U91cd\U5e86";
//    var NativeProvinceName = "\U91cd\U5e86";
//    var NickName = nicknick;
    var OrderID: Int = 0
    var OrderType: Int = 0
    var Price: Int = 0
    var ProductID: Int = 0
    var ProductName: String?
//    var RealName = hhhhhana;
    var Remark: String?
//    var Sex = 0
//    var SexName: = "\U5973";
    var UserID: Int = 0
    var UserInfoID: Int = 0
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map: Map) {
        CreateDate  <- map["CreateDate"]
        OrderID     <- map["OrderID"]
        OrderType   <- map["OrderType"]
        Price       <- map["Price"]
        ProductID   <- map["ProductID"]
        ProductName <- map["ProductName"]
        Remark      <- map["Remark"]
        UserID      <- map["UserID"]
        UserInfoID  <- map["UserInfoID"]
    }
}
