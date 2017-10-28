//
//  NVYSysObjModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/8/24.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

class NVYSysObjModel: Mappable {

    var ChildDictionaries: NSArray?
    
    var DictionaryTypeId: Int = 0
    
    var Id: Int = 0
    
    var Name: String?
    
    var ParentId: Int = 0
//    ParentDictionary = "<null>";
    
    required convenience init?(map: Map) {
        self.init()
        
    }
    
    func mapping(map: Map) {
        ChildDictionaries <- map["ChildDictionaries"]
        DictionaryTypeId  <- map["DictionaryTypeId"]
        Id                <- map["Id"]
        Name              <- map["Name"]
        ParentId          <- map["ParentId"]
    }
}
