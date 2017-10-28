//
//  NVYConversationVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/9/22.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

//这是import的头文件
import UIKit
import ObjectMapper

//这是声明一个类
class NVYConversationVC: RCConversationViewController {

    //这里可以写示例变量，如：
    //var a: Int = 0
    //let viewWidth: Float = 320.0
    
    //以下可以重写父类方法，或者自建方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func test1() {
        //这是一个函数，括号中可以放任意参数
    }
    
    //这是一个静态函数
    static func test2(a: Int) {
        //let b = 3
        //let c = b + a
        //print(c)
    }
    
    //这是一个私有函数，如果是公开的就public或者像上面一样不写
    private func test3() {
        
    }
    
    
    
    override func willDisplayMessageCell(_ cell: RCMessageBaseCell, at indexPath: IndexPath!) {
        
        let url: String? = cell.model.userInfo?.portraitUri
        
        if url == nil {
            let user = NVYUserModel.getUserModel()
            cell.model.userInfo?.portraitUri = "\(kBaseURL)\(user.IconSmall ?? "")"
        }
    }
    
    override func didSendMessage(_ status: Int, content messageContent: RCMessageContent!) {
        
        
        let data = messageContent.encode()
        let str = String.init(data: data!, encoding: .utf8)
        
        let start = str?.index((str?.startIndex)!, offsetBy: 12)
        let end = str?.index((str?.endIndex)!,offsetBy:-2)
        let text = str?.substring(with: start!..<end!)
        
        let user = NVYUserModel.getUserModel()
        NVYProfileDataTool.asynMessagess(text: text!, ower: user.UserInfoID, user: Int(targetId)!)

        super.didSendMessage(status, content: messageContent);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
