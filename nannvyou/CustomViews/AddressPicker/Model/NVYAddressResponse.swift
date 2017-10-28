//
//  NVYAddressResponse.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/17.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
//import Realm
import RealmSwift
import ObjectMapper_Realm
import ObjectMapper

class NVYAddressResponse: Object, Mappable {

    dynamic var state: Int = 0
    
    dynamic var msg: String?
    
    var cities: [NVYProviceModel]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    //这些是什么鬼，为什么要加这些
//    required init() {
//        fatalError("init() has not been implemented")
//    }
    
//    required init(realm: RLMRealm, schema: RLMObjectSchema) {
//        fatalError("init(realm:schema:) has not been implemented")
//    }
//    
//    required init(value: Any, schema: RLMSchema) {
//        fatalError("init(value:schema:) has not been implemented")
//    }
    
    
//    let realm = try! Realm()
//    let data = realm.objects(NVYProviceModel.self)
//    let province = data.first
//    
//    let cityes = province?.Cities?.first
//    let area = cityes?.Areas?.first
//    print(area!.AreaName!)
//    print("city acation")
    
    func mapping(map: Map) {
        state    <- map["state"]
        msg      <- map["msg"]
        cities   <- map["cities"]
    }
}
