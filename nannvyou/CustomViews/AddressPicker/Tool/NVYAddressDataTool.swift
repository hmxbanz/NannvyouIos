//
//  NVYAddressDataTool.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/16.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper
import PKHUD

class NVYAddressDataTool: NSObject {
    
    static func getFirstAddress(completion: @escaping (_ arr: Array<Any>) -> Void) {

        getAllCityInfo { () -> Void in
            
            var cityPlistPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
            
            cityPlistPath = cityPlistPath?.appending("/cities.plist")
            
            var json = [String: Any]()
            json = NSDictionary.init(contentsOfFile: cityPlistPath!) as! [String : Any]
            
            var jsonDict = NVYAddressResponse.init()
            jsonDict = Mapper<NVYAddressResponse>().map(JSONObject: json)!

            let cities = jsonDict.cities
            let provinceArr = cities
            let province = provinceArr?.first
            let cityArr = province?.Cities
            let city = cityArr?.first
            let areaArr = city?.Areas
                
            completion([provinceArr!, cityArr!, areaArr!])
            
            //闭包该如何向外传出多个数组数据？另外闭包不用像block那样检查是否被实现吗？
//        static func getFirstAddress(completion: @escaping (_ provinces: [NVYProviceModel], _ cities: [NVYCityModel], _ area: [NVYAreaModel]) -> Void) {
//            if completion != nil {
//            }
        }
    }
    
    //获取省以下的数据
    static func getAddressInfo(provinceID: Int, completion: @escaping (_ arr: Array<Any>) -> Void) {
        
        var cityPlistPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
        
        cityPlistPath = cityPlistPath?.appending("/cities.plist")
        
        var json = [String: Any]()
        json = NSDictionary.init(contentsOfFile: cityPlistPath!) as! [String : Any]
        
        var jsonDict = NVYAddressResponse.init()
        jsonDict = Mapper<NVYAddressResponse>().map(JSONObject: json)!
        
        let provinceArr = jsonDict.cities
        
        var province = NVYProviceModel()

        for provin in (provinceArr)! {
            if provin.Id == provinceID {
                province = provin
            }
        }
        
        let cityArr = province.Cities
        let city = cityArr?.first
        let areaArr = city?.Areas
        
        completion([cityArr!, areaArr!])
    }
    
    //获取市以下的数据
    static func getAddressInfo(provinceID: Int, cityID: Int, completion: @escaping (_ areas: Array<Any>) -> Void) {
        
        var cityPlistPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
        
        cityPlistPath = cityPlistPath?.appending("/cities.plist")
        
        var json = [String: Any]()
        json = NSDictionary.init(contentsOfFile: cityPlistPath!) as! [String : Any]
        
        //JSON转模型
        var jsonDict = NVYAddressResponse.init()
        jsonDict = Mapper<NVYAddressResponse>().map(JSONObject: json)!
        
        let provinceArr = jsonDict.cities

        var province = NVYProviceModel()
        
        for provin in (provinceArr)! {
            if provin.Id == provinceID {
                province = provin
            }
        }
        
        let cityArr = province.Cities
        
        var city = NVYCityModel()

        for cit in (cityArr)! {
            if cit.Id == cityID {
                city = cit
            }
        }
        
        let areaArr = city.Areas
        
        completion(areaArr!)
        
    }

    //获取地址的HTTP请求
    private static func getAllCityInfo(completion: @escaping () -> Void) {
        
        let url = kBaseURL.appending("/Nny/GetCities")
        
        HUD.show(.systemActivity)
        
        NVYHTTPTool.getMethod(url: url, params: nil) { (DataResponse) in
            
            var cityPlistPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
            
            cityPlistPath = cityPlistPath?.appending("/cities.plist")
            
            var jsonDict = NVYAddressResponse.init()
            jsonDict = Mapper<NVYAddressResponse>().map(JSONObject: DataResponse.result.value)!

            if jsonDict.state == 1 {
                
                let stringDict: NSDictionary = jsonDict.toJSON() as NSDictionary
                
                stringDict.write(toFile: cityPlistPath!, atomically: true)
                
                completion()
                
                HUD.hide()

                /*上方代码说明：
                 因为每次改变地址数据都要发送HTTP请求，太浪费流量。
                 故考虑把JSON保存到本地。
                 但DataResponse中已经把JSON转化为[String: Any]格式，因此用NSDictionary来保存数据*/
                
                /*
                 //JSON转模型的用法是这样子的？
                 let province = Mapper<NVYProviceModel>().map(JSONObject: jsonDict["cities"])
                 
                 //只要Model设置正确，上面的方法就可以完全转化地址的各级数据
                 let json: NSArray = (jsonDict["cities"] as? NSArray)!
                 
                 let dataArr = NSMutableArray()
                 
                 for item in json {
                 let model = item
                 
                 dataArr.add(model)
                 }
                 
                 let provices = NVYProviceModel(JSONString: json)
                 
                 
                 let data = realm.objects(NVYAddressResponse.self).filter("state == 1")
                 let city = data.first*/
            } else {
                HUD.flash(.label("获取数据失败"), delay: 1.0)
            }
            
        }
    }
    
    //获取地址的HTTP请求，请求超时，不用
    private static func getProviceInfo(completion: @escaping (_ dict: NSDictionary) -> Void) {
     
        let url = kBaseURL.appending("/Nny/GetPositions")
        
        
        NVYHTTPTool.getMethod(url: url, params: ["parentId": "0"]) { (DataResponse) in
            
//            let jsonDict = Mapper<NVYProviceModel>().map(JSONObject: DataResponse.result.value)!
//            
//            let cities = jsonDict.Cities
            
            
        }
    }
}
