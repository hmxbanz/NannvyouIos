//
//  NVYFriendConditionModel.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/8/26.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper

class NVYFriendConditionModel: NSObject, Mappable {

    var AgeMax: Int = 0
    var AgeMin: Int = 0
    var Area: String?;
    var AreaName: String?
    var Birthday: String?
    
//    var BodyHeight: String?
    var BodyHeightMax: Int = 0
    var BodyHeightMin: Int = 0
    
//    var BodyWeight: String?
    var BodyWeightMax: Int = 0
    var BodyWeightMin: Int = 0
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
    
    var MyConditionId: Int = 0
    var Remark: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
//        AgeRange  <- map["AgeRange"]
        AgeMax    <- map["AgeMax"]
        AgeMin    <- map["AgeMin"]
        Area     <- map["Area"]
        AreaName <- map["AreaName"]
        
        Birthday <- map["Birthday"]
        
//        BodyHeight <- map["BodyHeight"]
        BodyHeightMax <- map["BodyHeightMax"]
        BodyHeightMin <- map["BodyHeightMin"]
        
//        BodyWeight <- map["BodyWeight"]
        BodyWeightMax <- map["BodyWeightMax"]
        BodyWeightMin <- map["BodyWeightMin"]
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
        MyConditionId <- map["MyConditionId"]
        Remark <- map["Remark"]
    }
    
    //MARK: 地址信息
    
    func addressString() -> String? {
        let province = ProvinceName ?? "无";
        let city = CityName ?? "无";
        let area = AreaName ?? "无";
        let result = "\(province)-\(city)-\(area)";//(province) + "-"  + (city) + "-" + (area);
        return result;
    }
    
    func areaNameString(province: NVYProviceModel?, city: NVYCityModel?, area: NVYAreaModel?) -> String? {
        var result = "\((province?.ProvinceName)!) \((city?.CityName)!)";
        if area != nil{
            result = "\(result) \((area?.AreaName)!)";
        }
        return result;
    }
    
    func updateAddresInfo(province: NVYProviceModel?, city: NVYCityModel?, area: NVYAreaModel?) -> Void {
        self.Province = province?.ProvinceCode;
        self.ProvinceName = province?.ProvinceName;
        self.City = String(city?.Id ?? 0);
        self.CityName = city?.CityName;
        self.Area = String(area?.Id ?? 0);
        self.AreaName = area?.AreaName;
    }
    
    func nativeAddressString() -> String? {
        let province = NativeProvinceName ?? "无";
        let city = NativeCityName ?? "无";
        let area = NativeAreaName ?? "无";
        let result = "\(province)-\(city)-\(area)";
        return result;
    }
    
    func updateNativeAddressInfo(province: NVYProviceModel?, city: NVYCityModel?, area: NVYAreaModel?) -> Void {
        self.NativeProvince = province?.ProvinceCode;
        self.NativeProvinceName = province?.ProvinceName;
        self.NativeCity = String(city?.Id ?? 0);
        self.NativeCityName = city?.CityName;
        self.NativeArea = String(area?.Id ?? 0);
        self.NativeAreaName = area?.AreaName;
    }
    
    
    var areaDisplayString: String {
        let prov = ProvinceName != nil ? ProvinceName! + "-" : "";
        let city = CityName != nil ? CityName! + "-" : "";
        let area = AreaName != nil ? AreaName! + "" : "";
        let result = prov + city + area;
        return result;
    }
    
    var nativeAreaDisplayString: String {
        let prov = NativeProvinceName != nil ? NativeProvinceName! + "-" : "";
        let city = NativeCityName != nil ? NativeCityName! + "-" : "";
        let area = NativeAreaName != nil ? NativeAreaName! + "" : "";
        let result = prov + city + area;
        return result;
    }
    
    //MARK: 年龄范围
    func ageRangeString() -> String {
        let result = "\(AgeMin)-\(AgeMax)岁";
        return result;
    }
    
    func updateAgeRange(minValue: Int, maxValue: Int) -> Void {
        AgeMin = minValue;
        AgeMax = maxValue;
    }
    
    //MARK: 身高范围
    func bodyHeightRangeString() -> String {
        let result = "\(BodyHeightMin)-\(BodyHeightMax)CM";
        return result;
    }
    
    func updateBodyHeightRange(minValue: Int, maxValue: Int) -> Void {
        BodyHeightMin = minValue;
        BodyHeightMax = maxValue;
    }
    
    //MARK: 体重范围
    func bodyWeightRangeString() -> String {
        let result = "\(BodyWeightMin)-\(BodyWeightMax)KG";
        return result;
    }
    
    func updateBodyWeightRange(minValue: Int, maxValue: Int) -> Void {
        BodyWeightMin = minValue;
        BodyWeightMax = maxValue;
    }
    
    //MARK: 模型存储
    
    static func saveConditionModel(_ model: NVYFriendConditionModel) -> Bool {
        
        var home = NSHomeDirectory() as String
        home = home.appending("/Documents/userCondition.data")
        let data = model.toJSON()
        return NSKeyedArchiver.archiveRootObject(data, toFile: home)
    }
    
    static func getUserConditionModel() -> NVYFriendConditionModel {
        
        var home = NSHomeDirectory() as String
        home = home.appending("/Documents/userCondition.data")
        
        let data = NSKeyedUnarchiver.unarchiveObject(withFile: home) as? NSDictionary
        
        if data != nil {
            return Mapper<NVYFriendConditionModel>().map(JSONObject: data)!
        }
        return NVYFriendConditionModel()
    }
    
}
