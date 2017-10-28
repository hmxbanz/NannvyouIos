//
//  NVYProviceModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/16.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
//import Realm
//import RealmSwift
//import ObjectMapper_Realm
import ObjectMapper

class NVYProviceModel: Mappable {

    var ProvinceName: String?
    
    var ProvinceCode: String?
    
    var Cities: [NVYCityModel]?
    
    var Id: Int = 0

    
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map: Map) {
        ProvinceName    <- map["ProvinceName"]
        ProvinceCode    <- map["ProvinceCode"]
        Id              <- map["Id"]
        Cities          <- map["Cities"]
    }
    
}
