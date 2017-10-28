//
//  NVYUserModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/30.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

class NVYUserModel: NSObject, Mappable {

    var Age: Int = 0
    
    var Area: String?
    
    var AreaName: String?
    
    var Birthday: String?
    
    var BodyHeight: Int = 0
    
    var BodyWeight: Int = 0
    
    var Car: String?
    
    var CarName: String?
    
    var CellPhone: String?
    
    var Check: String?
    
    var CheckName: String?
    
    var City: String?
    
    var CityName: String?
    
    var CreateDate: String?
    
    var Education: String?
    
    var EducationName: String?
    
    var Email: String?
    
    var FavorCount: Int = 0
    
    var House: String?
    
    var HouseName: String?
    
    var IDnumber: String?
    
    var IconBig: String?
    
    var IconSmall: String?
    
    var Industry: String?
    
    var IndustryName: String?
    
    var LastLogInDate: String?
    
    var MaritalStatus: String?
    
    var MaritalStatusName: String?
    
    var ModifyDate: String?
    
    var Nation: String?
    
    var NationName: String?
    
    var NativeArea: String?
    
    var NativeAreaName: String?
    
    var NativeCity: String?
    
    var NativeCityName: String?
    
    var NativeProvince: String?
    
    var NativeProvinceName: String?
    
    var NickName: String?
    
    var NoReadMessage: Int = 0
    
    var Occupation: String?
    
    var OccupationName: String?
    
    var OutDate: String?
    
    var OutDateCount: Int = 0
    
//    Password = "123456
    var PersonalityDescribe: String?
    
    var Province: String?
    
    var ProvinceName: String?
    
    var QQ: String?
    
    var RealName: String?
    
    var RoleID: String?
    
    var RoleName: String?
    
    var RongCloudToken: String?
    
    var Salary: String?
    
    var SalaryName: String?
    
    var Score: String?
    
    var SelfDescribe: String?
    
    var Sex: String?
    
    var SexName: String?
    
    var Status: String?
    
    var StatusName: String?
    
    var Tel: String?
    
    var ThumbUpCount: Int = 0
    
    var UserID: Int = 0

    var UserInfoID: Int = 0
    
    var UserName: String?
    
    var VisitedCount: Int = 0
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
//    required init(_ userID: String) {
//        UserID = Int(userID)!
//    }
//    
//    required convenience init?(coder aDecoder: NSCoder) {
//        let userID = aDecoder.decodeObject(forKey: "UserID") as? String
//        self.init(userID!)
//    }
    
    
    func mapping(map: Map) {
        Age    <- map["Age"]
        Area    <- map["Area"]
        AreaName <- map["AreaName"]

        Birthday <- map["Birthday"]
        BodyHeight <- map["BodyHeight"]
        BodyWeight <- map["BodyWeight"]
        Car <- map["Car"]
        CarName  <- map["CarName"]
        CellPhone <- map["CellPhone"]
        Check <- map["Check"]
        CheckName <- map["CheckName"]
        City <- map["City"]
        CityName <- map["CityName"]
        CreateDate <- map["CreateDate"]
        Education <- map["Education"]
        EducationName <- map["EducationName"]
        Email <- map["Email"]
        FavorCount <- map["FavorCount"]
        House <- map["House"]
        HouseName <- map["HouseName"]
        IDnumber <- map["IDnumber"]
        IconBig <- map["IconBig"]
        IconSmall <- map["IconSmall"]
        Industry <- map["Industry"]
        IndustryName <- map["IndustryName"]


        LastLogInDate <- map["LastLogInDate"]
        MaritalStatus <- map["MaritalStatus"]
        MaritalStatusName <- map["MaritalStatusName"]
        ModifyDate <- map["ModifyDate"]
        Nation <- map["Nation"]
        NationName <- map["NationName"]
        NativeArea <- map["NativeArea"]
        NativeAreaName <- map["NativeAreaName"]
        NativeCity <- map["NativeCity"]
        NativeCityName <- map["NativeCityName"]
        NativeProvince <- map["NativeProvince"]
        NativeProvinceName <- map["NativeProvinceName"]
        NickName <- map["NickName"]
        NoReadMessage <- map["NoReadMessage"]
        Occupation <- map["Occupation"]
        OccupationName <- map["OccupationName"]
        OutDate <- map["OutDate"]
        OutDateCount <- map["OutDateCount"]

        PersonalityDescribe <- map["PersonalityDescribe"]
        Province <- map["Province"]
        ProvinceName <- map["ProvinceName"]
        QQ <- map["QQ"]
        RealName <- map["RealName"]
        RoleID <- map["RoleID"]
        RoleName <- map["RoleName"]
        RongCloudToken <- map["RongCloudToken"]
        Salary <- map["Salary"]
        SalaryName <- map["SalaryName"]
        Score <- map["Score"]
        SelfDescribe <- map["SelfDescribe"]
        Sex <- map["Sex"]
        SexName <- map["SexName"]
        Status <- map["Status"]
        StatusName <- map["StatusName"]
        Tel <- map["Tel"]
        ThumbUpCount <- map["ThumbUpCount"]
        UserID <- map["UserID"]
        UserInfoID <- map["UserInfoID"]
        UserName <- map["UserName"]
        VisitedCount <- map["VisitedCount"]
    }
    
    static func saveUserModel(_ model: NVYUserModel) -> Bool {
        
        var home = NSHomeDirectory() as String
        home = home.appending("/Documents/user.data")
        let data = model.toJSON()
        return NSKeyedArchiver.archiveRootObject(data, toFile: home)
    }
    
    static func getUserModel() -> NVYUserModel {
        
        var home = NSHomeDirectory() as String
        home = home.appending("/Documents/user.data")
        
        let data = NSKeyedUnarchiver.unarchiveObject(withFile: home) as? NSDictionary

        if data != nil {
            return Mapper<NVYUserModel>().map(JSONObject: data)!
        }
        return NVYUserModel()
    }
    
    static func removeUserModel() {
        let fileManager = FileManager()
        
        var home = NSHomeDirectory() as String
        home = home.appending("/Documents/user.data")
        
        try! fileManager.removeItem(atPath: home)
    }
    
    /*func encode(with aCoder: NSCoder) {
        aCoder.encode(Age, forKey: "Age")
        aCoder.encode(Area, forKey: "Area")
        aCoder.encode(AreaName, forKey: "AreaName")
        aCoder.encode(Birthday, forKey: "Birthday")
        aCoder.encode(BodyHeight, forKey: "BodyHeight")
        aCoder.encode(BodyWeight, forKey: "BodyWeight")
        aCoder.encode(Car, forKey: "Car")
        aCoder.encode(CarName, forKey: "CarName")
        aCoder.encode(CellPhone, forKey: "CellPhone")
        aCoder.encode(Check, forKey: "Check")
        aCoder.encode(CheckName, forKey: "CheckName")
        aCoder.encode(City, forKey: "City")
        aCoder.encode(CityName, forKey: "CityName")
        aCoder.encode(CreateDate, forKey: "CreateDate")
        aCoder.encode(Education, forKey: "Education")
        aCoder.encode(EducationName, forKey: "EducationName")
        aCoder.encode(Email, forKey: "Email")
        aCoder.encode(FavorCount, forKey: "FavorCount")
        aCoder.encode(House, forKey: "House")
        aCoder.encode(HouseName, forKey: "HouseName")
        aCoder.encode(IDnumber, forKey: "IDnumber")
        aCoder.encode(IconBig, forKey: "IconBig")
        aCoder.encode(IconSmall, forKey: "IconSmall")
        aCoder.encode(Industry, forKey: "Industry")
        aCoder.encode(IndustryName, forKey: "IndustryName")
        aCoder.encode(LastLogInDate, forKey: "LastLogInDate")
        aCoder.encode(MaritalStatus, forKey: "MaritalStatus")
        aCoder.encode(MaritalStatusName, forKey: "MaritalStatusName")
        aCoder.encode(ModifyDate, forKey: "ModifyDate")
        aCoder.encode(Nation, forKey: "Nation")
        aCoder.encode(NationName, forKey: "NationName")
        aCoder.encode(NativeArea, forKey: "NativeArea")
        aCoder.encode(NativeAreaName, forKey: "NativeAreaName")
        aCoder.encode(NativeCity, forKey: "NativeCity")
        aCoder.encode(NativeCityName, forKey: "NativeCityName")
        aCoder.encode(NativeProvince, forKey: "NativeProvince")
        aCoder.encode(NativeProvinceName, forKey: "NativeProvinceName")
        aCoder.encode(NickName, forKey: "NickName")
        aCoder.encode(NoReadMessage, forKey: "NoReadMessage")
        aCoder.encode(Occupation, forKey: "Occupation")
        aCoder.encode(OccupationName, forKey: "OccupationName")
        aCoder.encode(OutDate, forKey: "OutDate")
        aCoder.encode(OutDateCount, forKey: "OutDateCount")
        aCoder.encode(PersonalityDescribe, forKey: "PersonalityDescribe")
        aCoder.encode(Province, forKey: "Province")
        aCoder.encode(ProvinceName, forKey: "ProvinceName")
        aCoder.encode(QQ, forKey: "QQ")
        aCoder.encode(RealName, forKey: "RealName")
        aCoder.encode(RoleID, forKey: "RoleID")
        aCoder.encode(RoleName, forKey: "RoleName")
        aCoder.encode(RongCloudToken, forKey: "RongCloudToken")
        aCoder.encode(Salary, forKey: "Salary")
        aCoder.encode(SalaryName, forKey: "SalaryName")
        aCoder.encode(Score, forKey: "Score")
        aCoder.encode(SelfDescribe, forKey: "SelfDescribe")
        aCoder.encode(Sex, forKey: "Sex")
        aCoder.encode(SexName, forKey: "SexName")
        aCoder.encode(Status, forKey: "Status")
        aCoder.encode(StatusName, forKey: "StatusName")
        aCoder.encode(Tel, forKey: "Tel")
        aCoder.encode(ThumbUpCount, forKey: "ThumbUpCount")
        aCoder.encode(UserID, forKey: "UserID")
        aCoder.encode(UserInfoID, forKey: "UserInfoID")
        aCoder.encode(UserName, forKey: "UserName")
        aCoder.encode(VisitedCount, forKey: "VisitedCount")
    }*/
    
}
