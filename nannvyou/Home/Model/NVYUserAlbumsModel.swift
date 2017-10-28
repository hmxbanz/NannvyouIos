//
//  NVYUserAlbumsModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/9/3.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

class NVYUserAlbumsModel: Mappable {

    var AlbumCreateDate: String?
    var AlbumID: Int = 0
    var AlbumName: String?
    var AlbumPhotoID: Int = 0
    var Check: String?
    var CheckName: String?
    var IsCover: Int = 0
    var IsDelete: String?
    var NickName: String?
    var PhotoBig: String?
    var PhotoCreateDate: String?
    var PhotoInfo: String?
    var PhotoSmall: String?
//    var Type: Int = 0
    var UserInfoID: Int = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        AlbumCreateDate <- map["AlbumCreateDate"]
        AlbumID         <- map["AlbumID"]
        AlbumName       <- map["AlbumName"]
        AlbumPhotoID    <- map["AlbumPhotoID"]
        Check           <- map["Check"]
        CheckName       <- map["CheckName"]
        IsCover         <- map["IsCover"]
        IsDelete        <- map["IsDelete"]
        NickName        <- map["NickName"]
        PhotoBig        <- map["PhotoBig"]
        PhotoCreateDate <- map["PhotoCreateDate"]
        PhotoInfo       <- map["PhotoInfo"]
        PhotoSmall      <- map["PhotoSmall"]
//        Type = 1;
        UserInfoID      <- map["UserInfoID"]
    }
    
}
