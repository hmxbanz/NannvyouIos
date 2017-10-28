//
//  NVYVisitModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/9/1.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

class NVYVisitModel: Mappable {

    var CreateDate: String?
    var ObjectIcon: String?
    var ObjectNickName: String?
    var ObjectUserID: Int = 0
    var ObjectUserInfoID: Int = 0
    var OwnerIcon: String?
    var OwnerNickName: String?
    var OwnerUserID: Int = 0
    var OwnerUserInfoID: Int = 0
    var VisitRecordID: Int = 0
    
    //收藏用的
    var FavorID: Int = 0

    required convenience init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map: Map) {
        CreateDate <- map["CreateDate"]
        ObjectIcon     <- map["ObjectIcon"]
        ObjectNickName   <- map["ObjectNickName"]
        ObjectUserID    <- map["ObjectUserID"]
        ObjectUserInfoID      <- map["ObjectUserInfoID"]
        OwnerIcon  <- map["OwnerIcon"]
        OwnerNickName  <- map["OwnerNickName"]
        OwnerUserID     <- map["OwnerUserID"]
        OwnerUserInfoID     <- map["OwnerUserInfoID"]
        VisitRecordID   <- map["VisitRecordID"]
        FavorID <- map["FavorID"]
    }
}
