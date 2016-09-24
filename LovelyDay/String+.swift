//
//  String+.swift
//  LovelyDay
//
//  Created by Elise on 16/6/4.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation


extension String {
    /// 将字符串转换成经纬度
    func stringToCLLocationCoordinate2D(_ separator: String) -> CLLocationCoordinate2D? {
        let arr = self.components(separatedBy: separator)
        //字符串事例"120.200365,30.288461"
        if arr.count != 2 {
            return nil
        }
        let latitude: Double = NSString(string: arr[1]).doubleValue
        let longitude: Double = NSString(string: arr[0]).doubleValue
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
