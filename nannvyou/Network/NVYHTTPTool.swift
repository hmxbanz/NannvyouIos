//
//  NVYHTTPTool.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/14.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD

typealias HTTPRESULT = (_ dict: DataResponse<Any>) -> Void

class NVYHTTPTool: NSObject {
    
//    static func initHTTPManager() ->  {
//        
//    }
    
    static func getMethod(hud: Bool, url: URLConvertible, params: Parameters?, completion: @escaping HTTPRESULT) {
        
        if hud {
            HUD.show(.systemActivity, onView: nil)
        }
        
        Alamofire.request(url,
                          method: .get,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: nil).responseJSON(completionHandler: { (DataResponse) in
                            
                            switch DataResponse.result {
                            case .success:
                                HUD.hide()
                                print("\(DataResponse)")
                                completion(DataResponse)
                                break
                                
                            case .failure:
                                HUD.flash(.labeledError(title: "网络出错", subtitle: ""), delay: 1.0)
                                break
                            }
                            
                          })
    }

    static func getMethod(url: URLConvertible, params: Parameters?, completion: @escaping HTTPRESULT) {
        
        HUD.show(.systemActivity, onView: nil)
        
        Alamofire.request(url,
                          method: .get,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: nil).responseJSON(completionHandler: { (DataResponse) in
                        
                            switch DataResponse.result {
                            case .success:
                                HUD.hide()
                                print("\(DataResponse)")
                                completion(DataResponse)
                                break
                                
                            case .failure:
                                HUD.flash(.labeledError(title: "网络出错", subtitle: ""), delay: 1.0)
                                break
                            }
                            
                          })
    }
    
    static func postMethod(hud: Bool, url: URLConvertible, params: Parameters?, completion: @escaping HTTPRESULT) {
        
        if hud {
            HUD.show(.systemActivity, onView: nil)
        }
        
        Alamofire.request(url,
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: nil).responseJSON(completionHandler: { (DataResponse) in
                            
                            switch DataResponse.result {
                            case .success:
                                HUD.hide()
                                print("\(DataResponse)")
                                completion(DataResponse)
                                break
                                
                            case .failure:
                                HUD.flash(.labeledError(title: "网络出错", subtitle: ""), delay: 1.0)
                                break
                            }
                          })
    }
    
    static func postMethod(url: URLConvertible, params: Parameters?, completion: @escaping HTTPRESULT) {
        
        HUD.show(.systemActivity, onView: nil)

        Alamofire.request(url,
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: nil).responseJSON(completionHandler: { (DataResponse) in
                            
                            switch DataResponse.result {
                            case .success:
                                HUD.hide()
                                print("\(DataResponse)")
                                completion(DataResponse)
                                break
                                
                            case .failure:
                                HUD.flash(.labeledError(title: "网络出错", subtitle: ""), delay: 1.0)
                                break
                            }
        })
    }
    
    static func uploadPic(url: URLConvertible, images: Array<UIImage>, params: Parameters?, completion: @escaping (_ result: Bool ) -> Void) {
        
        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                if params != nil {
                    for key in params!.keys {
                        let value = params![key] as! String
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                }
                
                let data = NSMutableArray()
                
                for image in images {
                    
                    let imgData = UIImageJPEGRepresentation(image, 0.5)
                    data.add(imgData!)
                }
                
                for i in 0..<data.count {
                    multipartFormData.append(data[i] as! Data, withName: "imgFile", fileName: "img.jpg", mimeType: "image/jpg")
                }
        },
            to: url,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            let state = value["state"] as? Int
                            if state == 1 {
                                completion(true)
                            } else {
                                HUD.flash(.labeledError(title: value["msg"] as? String, subtitle: ""), delay: 1.0)
                                completion(false)
                            }
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    completion(false)
                }
        })

    }
}
