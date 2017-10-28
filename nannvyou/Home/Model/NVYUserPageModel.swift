//
//  NVYUserPageModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/8/5.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

//这个模型会有多层嵌套，不知道如何做
//那么就先定义为字典，再取出，再转化

import UIKit
import ObjectMapper

class NVYUserPageModel: NSObject, Mappable {

    var AlbumPhotoes: NSArray?// = "<null>";
    var AuthorityList: NSArray?// = "<null>";
    var ErrMessage: String?// = "<null>";
    var FriendCondition: NSDictionary?// =     {

    var LifeShare: String?// = "<null>";
    var LifeShares: NSArray?// = "<null>";
    var PageHeader: String?// = "<null>";
    var ShowPhotos: NSArray?// = "<null>";
    var UrlReferrer: String?// = "<null>";
    var UserAccount: String?// = "<null>";
    var UserAlbums: NSArray?// = "<null>";
    var UserInfo: NSDictionary?// =     {
    var UserMessage: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        AlbumPhotoes     <- map["AlbumPhotoes"]
        AuthorityList   <- map["AuthorityList"]
        ErrMessage    <- map["ErrMessage"]
        FriendCondition   <- map["FriendCondition"]
        LifeShare   <- map["LifeShare"]
        LifeShares   <- map["LifeShares"]
        PageHeader   <- map["PageHeader"]
        ShowPhotos   <- map["ShowPhotos"]
        UrlReferrer   <- map["UrlReferrer"]
        UserAccount   <- map["UserAccount"]
        UserAlbums   <- map["UserAlbums"]
        UserInfo     <- map["UserInfo"]
        UserMessage   <- map["UserMessage"]
    }
    
}


//    AgeMax = "<null>";
//    AgeMin = "<null>";
//    Area = "<null>";
//    AreaName = "<null>";
//    BodyHeightMax = "<null>";
//    BodyHeightMin = "<null>";
//    BodyWeightMax = "<null>";
//    BodyWeightMin = "<null>";
//    Car = "<null>";
//    CarName = "<null>";
//    City = "<null>";
//    CityName = "<null>";
//    Education = "<null>";
//    EducationName = "<null>";
//    House = "<null>";
//    HouseName = "<null>";
//    MaritalStatus = "<null>";
//    MaritalStatusName = "<null>";
//    MyConditionId = 0;
//    NativeArea = "<null>";
//    NativeAreaName = "<null>";
//    NativeCity = "<null>";
//    NativeCityName = "<null>";
//    NativeProvince = "<null>";
//    NativeProvinceName = "<null>";
//    Province = "<null>";
//    ProvinceName = "<null>";
//    Remark = "<null>";
//    Salary = "<null>";
//    SalaryName = "<null>";
//    };




//    Address = "<null>";
//    Age = 26;
//    Area = 1551;
//    AreaName = "\U91d1\U5e73\U533a";
//    AuthorityList = "<null>";
//    Birthday = "/Date(681926400000)/";
//    BodyHeight = 168;
//    BodyWeight = 51;
//    Car = 38;
//    CarName = "\U6682\U672a\U8d2d\U8f66";
//    CellPhone = "13888800025         ";
//    Check = 52;
//    CheckName = "\U5df2\U5ba1\U6838";
//    City = 1095;
//    CityName = "\U6c55\U5934";
//    CreateDate = "/Date(1470988589643)/";
//    Education = 15;
//    EducationName = "\U672c\U79d1";
//    Email = "12345678@qq.com";
//    FavorCount = 0;
//    House = 32;
//    HouseName = "\U672a\U8d2d\U623f";
//    IDnumber = "<null>";
//    IconBig = "/Images/User/2016/08/12/2016081215564577_b.jpg";
//    IconSmall = "/Images/User/2016/08/12/2016081215564577_s.jpg";
//    Industry = 21;
//    IndustryName = "\U4e8b\U4e1a\U5355\U4f4d";
//    IsHomePage = "<null>";
//    IsRealPerson = "<null>";
//    LastLogInDate = "/Date(1498269918837)/";
//    MaritalStatus = 42;
//    MaritalStatusName = "\U672a\U5a5a";
//    ModifyDate = "<null>";
//    Nation = 6;
//    NationName = "\U6c49\U65cf";
//    NativeArea = 1552;
//    NativeAreaName = "\U9f99\U6e56\U533a";
//    NativeCity = 1095;
//    NativeCityName = "\U6c55\U5934";
//    NativeProvince = 1005;
//    NativeProvinceName = "\U5e7f\U4e1c";
//    NickName = "\U7231\U5728\U8eab\U8fb9";
//    NoReadMessage = 3;
//    Occupation = 48;
//    OccupationName = "\U533b\U5e08";
//    OutDate = "<null>";
//    OutDateCount = "<null>";
//    Password = "123                 ";
//    PersonalityDescribe = "<null>";
//    Province = 1005;
//    ProvinceName = "\U5e7f\U4e1c";
//    QQ = 12345678;
//    RealName = "\U9648\U5c0f\U59d0";
//    RoleID = 3;
//    RoleName = "\U7528\U6237";
//    RongCloudToken = "<null>";
//    Salary = 27;
//    SalaryName = "2000-5000";
//    Score = 12;
//    SelfDescribe = "\U6211\U662f\U4e00\U4e2a\U5f00\U6717,\U4e50\U89c2,\U6e29\U67d4\U7684\U4eba \Uff0c\U7231\U597d\U5e7f\U6cdb\U7684\U6211\Uff0c\U559c\U6b22\U65c5\U884c\Uff0c\U5173\U4e8e\U5916\U8c8c\Uff0c\U7b80\U5355\U5f62\U5bb9\U5c31\U662f\U8eab\U6750\U5300\U79f0\U3002";
//    Sex = 0;
//    SexName = "\U5973";
//    Status = 1;
//    StatusName = "\U5f00\U901a";
//    Tel = "<null>";
//    ThumbUpCount = 3;
//    UserID = 72;
//    UserInfoID = 72;
//    UserName = "13888800025         ";
//    VisitedCount = 17;
//    };
