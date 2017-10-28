//
//  NVYCityModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/16.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
//import RealmSwift
//import ObjectMapper_Realm
import ObjectMapper

class NVYCityModel: Mappable {

    dynamic var CityName: String?
    
    dynamic var ProvinceId: Int = 0
    
//    dynamic var ProvinceParent: String?
    
    var Areas: [NVYAreaModel]?
    
    dynamic var Id: Int = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map: Map) {
        CityName      <- map["CityName"]
        ProvinceId    <- map["ProvinceId"]
        Id            <- map["Id"]
        Areas         <- map["Areas"]
    }
}
