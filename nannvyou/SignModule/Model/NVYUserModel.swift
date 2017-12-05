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
    
    var Area: Int?
    
    var AreaName: String?
    
    var Birthday: String?
    
    var BodyHeight: Int = 0
    
    var BodyWeight: Int = 0
    
    var Car: String?
    
    var CarName: String?
    
    var CellPhone: String?
    
    var Check: Int?
    
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
    
    var Nation: Int?
    
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
    
    var RoleID: Int?
    
    var RoleName: String?
    
    var RongCloudToken: String?
    
    var Salary: Int?
    
    var SalaryName: String?
    
    var Score: Int?
    
    var SelfDescribe: String?
    
    var Sex: Int?
    
    var SexName: String?
    
    var Status: Int?
    
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
    
    func transformModel() -> NVYUserEditInfoModel {
        let model = NVYUserEditInfoModel ();
        model.NickName = self.NickName;
        model.RealName = self.RealName;
        model.QQ = self.QQ;
        model.Email = self.Email;
        model.SelfDescribe = self.SelfDescribe;
        model.Sex = self.Sex ?? 1;//Int(self.Sex ?? "1")!;
        if (self.Birthday?.contains("Date"))! {
            //解析服务器返回的日期格式 /Date(280771200000)/
            let date = self.Birthday?.nvy_dateFromCsDate();
            let dateString = date?.nvy_DateStringOfChina();
            model.Birthday = dateString;
        }
        model.BodyHeight = String(self.BodyHeight);
        model.BodyWeight = String(self.BodyWeight);
        model.Occupation = "\(self.IndustryName ?? "无") \(self.OccupationName ?? "无")";
        model.Area = self.AreaName;
        model.NativeArea = self.NativeArea;
        model.MaritalStatus = self.MaritalStatus;
        model.Education = self.Education;
        model.Salary = self.SalaryName;
        model.House = self.House;
        model.Car = self.Car;
        model.Nation = self.NationName;
        return model;
    }
    
    func birthdayDisplayString() -> String? {
        if (self.Birthday?.contains("Date"))! {
            //解析服务器返回的日期格式 /Date(280771200000)/
            let date = self.Birthday?.nvy_dateFromCsDate();
            let dateString = date?.nvy_DateStringOfChina();
            return dateString;
        }
        return self.Birthday;
    }
    
    func occupationDisplayString() -> String? {
        if self.IndustryName == nil && self.OccupationName == nil {
            return nil;
        }
        let result = "\(self.IndustryName ?? "无") \(self.OccupationName ?? "无")";
        return result;
    }
    
    func isUserChecked() -> Bool {
        let check = self.Check ?? 0;
        return (check == 52);
    }
    
    static func autoLoginIfNeed(){
        if NVYUserModel.isLogined() {
            if let info = UserDefaults.standard.value(forKey: "NVYLoginUserInfo") {
                let userInfo = info as! Dictionary<String, String?>;
                let loginModel = NVYLoginRequestModel()
                loginModel.userName = userInfo["NVYUserName"]!;
                loginModel.password = userInfo["NVYUserPwd"]!;
                NVYSignDataTool.userLogin(loginModel: loginModel) { (Bool) in
                    
                }
            }
            
//            let userInfo =  as! Dictionary<String, String?>?;
        }
    }
    
    static func saveLoginUser(userName: String?, password: String?) -> Void {
        let userInfo = ["NVYUserName": userName,
                        "NVYUserPwd": password];
        UserDefaults.standard.setValue(userInfo, forKey: "NVYLoginUserInfo");
        UserDefaults.standard.synchronize();
    }
    
    static func removeLoginUser(){
        UserDefaults.standard.removeObject(forKey: "NVYLoginUserInfo");
        UserDefaults.standard.synchronize();
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
    
    static func isLogined() -> Bool {
        return NVYUserModel.getUserModel().RongCloudToken != nil;
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
