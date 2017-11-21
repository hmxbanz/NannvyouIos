//
//  NSString+Date.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/9/12.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import Foundation

extension String {

    //"/Date(1486179457417)/"
    //从上述的时间格式中提取正确的时间 返回年月日时分秒
    func lwz_changeTime() -> String {

        let start = self.index(self.startIndex, offsetBy: 6)
        let end = self.index(self.endIndex,offsetBy:-5)
        let newTimeStr = self.substring(with: start..<end)
        
        let date1 = Date(timeIntervalSince1970: TimeInterval(newTimeStr)!)
        //时间转化
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStr = dateFormat.string(from: date1)
        
        return dateStr
    }
    
    //"/Date(1486179457417)/"
    //从上述的时间格式中提取正确的时间 返回年月日
    func lwz_getShortTime() -> String {
        
        let start = self.index(self.startIndex, offsetBy: 6)
        let end = self.index(self.endIndex,offsetBy:-5)
        let newTimeStr = self.substring(with: start..<end)
        
        let date1 = Date(timeIntervalSince1970: TimeInterval(newTimeStr)!)
        //时间转化
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFormat.string(from: date1)
        
        return dateStr
    }
    
    //将C#格式的日期字符串转成iOS日期
    func nvy_dateFromCsDate() -> Date {
        let csDate = self;
        let startIndex = csDate.index((csDate.index(of: "("))!, offsetBy: 1);
        let endIndex = csDate.index(of: ")");
        let intervalString = csDate.substring(with: startIndex ..< endIndex);
        let interval = (intervalString as NSString).doubleValue / 1000; //C#的时间戳是毫秒级的
        let result = Date.init(timeIntervalSince1970: interval);
        return result;
    }
}
