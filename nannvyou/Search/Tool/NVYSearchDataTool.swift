//
//  NVYSearchDataTool.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/16.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import ObjectMapper
import PKHUD

class NVYSearchDataTool: NSObject {

    static func searchAction(page: Int, searchModel: NVYSearchRequstModel, completion: @escaping (_ models: Array<NVYSearchResponseModel>) -> Void) {
        
        searchModel.pageIndex = page
        searchModel.pageSize = 20
        let parameter = searchModel.toJSON()
        
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/Home/Search", params: parameter) { (DataResponse) in
            
            print("搜索回调 = \(DataResponse)")
            
            let responseDict = DataResponse.result.value as? NSDictionary
            
            //TODO:当没有数据返回时，这里会崩溃
            
            let state = responseDict?["state"] as? Int
            if (state == 1) {

                let dict = DataResponse.result.value as? NSDictionary
                
                let searchResponse = Mapper<NVYSearchResponseModel>().mapArray(JSONObject: dict?["UserList"])
                    //Mapper<NVYSearchResponseModel>().mapArray(JSONObject: DataResponse.result.value)
                    //.mapArray(JSONString:  as! String)
                    //.mapArray(JSONArray: [DataResponse.result.value as! [String : Any]])
                // .map(JSON: , toObject: NVYSearchResponseModel)!
                HUD.hide()

                completion(searchResponse!)
            } else {
                HUD.flash(.label(responseDict?["msg"]! as? String), delay: 1.0)
                print(responseDict?["msg"]! as Any)
                completion([])
            }
        }
    }
}
