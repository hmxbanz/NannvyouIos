//
//  NVYFriendModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/9/12.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

class NVYFriendModel: Mappable {

    var CreateDate: String?
    var FriendID: Int = 0
    var ObjectIcon: String?
    var ObjectNickName: String?
    var ObjectUserID: Int = 0
    var ObjectUserInfoID: Int = 0
    var OwnerIcon: String?
    var OwnerNickName: String?
    var OwnerUserID: Int = 0
    var OwnerUserInfoID: Int = 0
    
    required convenience init?(map: Map) {
        self.init()
        
    }
    
    func mapping(map: Map) {
        CreateDate       <- map["CreateDate"]
        FriendID         <- map["FriendID"]
        ObjectIcon       <- map["ObjectIcon"]
        ObjectNickName   <- map["ObjectNickName"]
        ObjectUserID     <- map["ObjectUserID"]
        ObjectUserInfoID <- map["ObjectUserInfoID"]
        OwnerIcon        <- map["OwnerIcon"]
        OwnerNickName    <- map["OwnerNickName"]
        OwnerUserID      <- map["OwnerUserID"]
        OwnerUserInfoID  <- map["OwnerUserInfoID"]
    }

}
