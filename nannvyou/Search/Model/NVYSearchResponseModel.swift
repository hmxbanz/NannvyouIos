//
//  NVYSearchResponseModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/21.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

class NVYSearchResponseModel: Mappable {

    var CityName: String?
    var IconSmall: String?
    var NickName: String?
    var ProvinceName: String?
    var RealName: String?
    var UserID: String?
    var UserInfoID: Int = 0
    var UserName: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        CityName     <- map["CityName"]
        IconSmall    <- map["IconSmall"]
        NickName     <- map["NickName"]
        ProvinceName <- map["ProvinceName"]
        RealName     <- map["RealName"]
        UserID       <- map["UserID"]
        UserInfoID   <- map["UserInfoID"]
        UserName     <- map["UserName"]
    }

    
//    TotalPages = 1;
//    UserList =     (
//    Age = 25;
//    Area = 1554;
//    AreaName = "\U6f6e\U9633\U533a";
//    Birthday = "/Date(699724800000)/";
//    BodyHeight = 167;
//    BodyWeight = 53;
//    CellPhone = "13413440406         ";
//    City = 1095;
//    CreateDate = "/Date(1493402398253)/";
//    Education = 2;
//    EducationName = "\U9ad8\U4e2d";
//    Email = "545228600@qq.com";
//    FavorCount = 0;
//    IconBig = "/Images/User/2017/04/29/2017042902063540_b.jpg";
//    Industry = 19;
//    IndustryName = "IT\U884c\U4e1a";
//    IsHomePage = "<null>";
//    IsRealPerson = "<null>";
//    LastLogInDate = "<null>";
//    MaritalStatus = 42;
//    MaritalStatusName = "\U672a\U5a5a";
//    ModifyDate = "/Date(1493402795587)/";
//    Nation = 6;
//    NationName = "\U6c49\U65cf";
//    NativeArea = 1554;
//    NativeAreaName = "\U6f6e\U9633\U533a";
//    NativeCity = 1095;
//    NativeCityName = "\U6c55\U5934";
//    NativeProvince = 1005;
//    NativeProvinceName = "\U5e7f\U4e1c";
//    NoReadMessage = 0;
//    Occupation = 95;
//    OccupationName = "\U7f51\U5e97\U5ba2\U670d";
//    OutDate = "<null>";
//    OutDateCount = "<null>";
//    Password = "XG13413440406       ";
//    PersonalityDescribe = "<null>";
//    Province = 1005;
//    QQ = "<null>";
//    RoleID = 3;
//    RoleName = "\U7528\U6237";
//    RongCloudToken = "<null>";
//    Salary = 27;
//    SalaryName = "2000-5000";
//    Score = "<null>";
//    SelfDescribe = "\U8fd8\U597d";
//    Sex = 1;
//    SexName = "\U7537";
//    Status = 1;
//    StatusName = "\U5f00\U901a";
//    Tel = "<null>";
//    ThumbUpCount = 0;
//    VisitedCount = 0;
    
    
}
