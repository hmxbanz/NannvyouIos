//
//  NVYNoteModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/9/12.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

class NVYNoteModel: Mappable {

    var Additional: String?
    var Check: Int = 0
    var CheckName: String?
    var Content: String?
    var CreateDate: String?
    var MessageID: Int = 0
    var ObjectIconSmall: String?
    var ObjectNickName: String?
    var ObjectNoReadedCount: Int = 0
    var ObjectUserInfoID: Int = 0
    var OwnerIconSmall: String?
    var OwnerNickName: String?
    var OwnerNoReadedCount: Int = 0
    var OwnerUserInfoID: Int = 0
    var SessionID: Int = 0
    var Title: String?
    var noteType = 2;
    var rownum: Int = 0

    required convenience init?(map: Map) {
        self.init()
        
    }
    
    func mapping(map: Map) {
        Additional          <- map["Additional"]
        Check               <- map["Check"]
        CheckName           <- map["CheckName"]
        Content             <- map["Content"]
        CreateDate          <- map["CreateDate"]
        MessageID           <- map["MessageID"]
        ObjectIconSmall     <- map["ObjectIconSmall"]
        ObjectNickName      <- map["ObjectNickName"]
        ObjectNoReadedCount <- map["ObjectNoReadedCount"]
        ObjectUserInfoID    <- map["ObjectUserInfoID"]
        OwnerIconSmall      <- map["OwnerIconSmall"]
        OwnerNickName       <- map["OwnerNickName"]
        OwnerNoReadedCount  <- map["OwnerNoReadedCount"]
        OwnerUserInfoID     <- map["OwnerUserInfoID"]
        SessionID           <- map["SessionID"]
        Title               <- map["Title"]
        noteType            <- map["Type"]
        rownum              <- map["rownum"]
    }

}
