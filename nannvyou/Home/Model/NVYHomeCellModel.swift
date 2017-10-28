//
//  NVYHomeCellModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/8/3.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

class NVYHomeCellModel: Mappable {

    var Content: String?// = "\U8c22\U8c22\Uff01\U6211\U60f3\U627e\U5973\U670b\U53cb\U3002";
    
    var CreateDate: String?// = "/Date(1498381776443)/";
    
    var IconSmall: String?// = "/Images/User/2017/06/25/2017062508190089_s.jpg";
    
    var IconBig: String?

    var LifePhotoes: NSArray?// =             (

    var LifeShareID: String?// = 129;
    
    var NickName: String?// = "\U4f60\U662f\U6211\U8d70\U8fdc";
    
    var UserInfoID: Int = 0// = 1313
    var AreaName: String?
    var CityName: String?
    required convenience init?(map: Map) {
        self.init()
    }

    
    func mapping(map: Map) {
        NickName     <- map["NickName"]
        UserInfoID   <- map["UserInfoID"]
        IconSmall    <- map["IconSmall"]
        IconBig      <- map["IconBig"]
        Content      <- map["Content"]
        LifePhotoes  <- map["LifePhotoes"]
        LifeShareID  <- map["LifeShareID"]
        AreaName     <- map["AreaName"]
        CityName     <- map["CityName"]
//        userName   <- map["userName"]
//        password   <- map["password"]
    }
}
