//
//  Date+NVY.swift
//  nannvyou
//
//  Created by Danplin on 2017/11/6.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import Foundation

extension Date {
    
    //返回中国时区的日期。格式为YYYY-MM-dd
    func nvy_DateStringOfChina() -> String {
        let formater = DateFormatter();
        formater.timeZone = TimeZone.init(identifier: "Asia/Shanghai");
        formater.dateFormat = "YYYY-MM-dd";
        let result = formater.string(from: self);
        return result;
    }
}
