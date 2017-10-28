//
//  NVYAlbumDetailModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/9/11.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

class NVYAlbumDetailModel: Mappable {
    
    var AlbumID: Int = 0
    var AlbumPhotoID: Int = 0
    var PhotoBig: String?
    var PhotoInfo: String?
    var PhotoSmall: String?
    var IsCover: Int = 0
    var IsDelete: Int = 0

    required convenience init?(map: Map) {
        self.init()
        
    }
    
    func mapping(map: Map) {
        AlbumID       <- map["AlbumID"]
        AlbumPhotoID  <- map["AlbumPhotoID"]
        PhotoBig      <- map["PhotoBig"]
        PhotoInfo     <- map["PhotoInfo"]
        PhotoSmall    <- map["PhotoSmall"]
        IsCover       <- map["IsCover"]
        IsDelete      <- map["IsDelete"]
    }
}
