//
//  LocationManager.swift
//  LovelyDay
//
//  Created by Elise on 16/6/3.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation
class LocationManager: NSObject {
    
    fileprivate static let sharedInstance = LocationManager()
    var userPosition: CLLocationCoordinate2D?
    fileprivate lazy var locationManager:CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        return locationManager
    }()
    
    
    class var sharedUserInfoManager: LocationManager {
        return sharedInstance
    }
    fileprivate override init() {}
    
    /// 获取用户位置授权,定位用户当前坐标
    func startUserlocation() {
        locationManager.autoContentAccessingProxy
        locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userPos = locations[0] as CLLocation
        userPosition = userPos.coordinate
        //            print("定位定位")
        locationManager.stopUpdatingLocation()
        
    }
    
}
