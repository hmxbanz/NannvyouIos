//
//  NVYAreaModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/16.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
//import RealmSwift
//import ObjectMapper_Realm
import ObjectMapper

class NVYAreaModel: Mappable {

    dynamic var AreaName: String?
    
    dynamic var CityId: Int = 0
    
//    open let CityParent:
    
    dynamic var Id: Int = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
//    override class func primaryKey() -> String? {
//        return "Id"
//    }
    
    func mapping(map: Map) {
        AreaName    <- map["AreaName"]
        CityId      <- map["CityId"]
        Id          <- map["Id"]
    }
}
