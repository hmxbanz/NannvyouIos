//
//  NVYMyAlbumModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/9/9.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

class NVYMyAlbumModel: Mappable {

    var AlbumCreateDate: String?
    var AlbumID: Int = 0
    var AlbumName: String?
    var AlbumPhotoID = 426;
//    var Check = "<null>";
//    var CheckName = "\U672a\U5ba1\U6838";
    var IsCover: Int = 0
    var IsDelete: Int = 0
    var NickName: String?
    var PhotoBig: String?
    var PhotoCreateDate: String?
    var PhotoInfo: String?
    var PhotoSmall: String?
//    var Type = 1;
    var UserInfoID: Int = 0
    
    required convenience init?(map: Map) {
        self.init()
        
    }
    
    func mapping(map: Map) {
        AlbumCreateDate <- map["AlbumCreateDate"]
        AlbumID <- map["AlbumID"]
        AlbumName   <- map["AlbumName"]
        AlbumPhotoID    <- map["AlbumPhotoID"]
        
        
        IsCover <- map["IsCover"]
        IsDelete    <- map["IsDelete"]
        NickName    <- map["NickName"]
        PhotoBig    <- map["PhotoBig"]
        PhotoCreateDate <- map["PhotoCreateDate"]
        PhotoInfo   <- map["PhotoInfo"]
        PhotoSmall  <- map["PhotoSmall"]

        UserInfoID  <- map["UserInfoID"]
    }
}
