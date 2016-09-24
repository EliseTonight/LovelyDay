//
//  UserModel.swift
//  LovelyDay
//
//  Created by Elise on 16/5/31.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation



///usermodel
class UserModel:NSObject {
    ///
    var sign:String?
    ///
    var background_url:String?
    ///
    var name:String?
    ///
    var head_photo:String?
    ///
    var phone:String?
    ///
    var email:String?
}

class UserModels:NSObject,DictModelProtocol {
    
    var data:UserModel?
    
    //载入本地数据
    class func loadUserModels(_ completion:(_ data:UserModels?,_ error:NSError?) -> ()) {
        let path = Bundle.main.path(forResource: "userData", ofType: nil)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
//                print(data)
        if data != nil {
            let dict = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
            let tools = DictModelManager.sharedManager
            let finalData = tools.objectWithDictionary(dict!, cls: UserModels.self) as? UserModels
//            print(finalData?.data?.sign)
            completion(finalData, nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["data":"\(UserModel.self)"]
    }
    
    
    
}






class UserHistoryModel:NSObject {
    ///4为动画创建一个小窗口
    var root_type:Int = -1
    ///时间
    var date:String?
    ///
    var url:String?
    ///
    var content:String?
    ///
    var img:String?
}


class UserHistoryModels:NSObject,DictModelProtocol {
    var list:[UserHistoryModel]?
    
    //载入本地数据
    class func loadUserHistoryModels(_ completion:(_ data:UserHistoryModels?,_ error:NSError?) -> ()) {
        let path = Bundle.main.path(forResource: "userHistory", ofType: nil)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        if data != nil {
            let dict = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
            
            let tools = DictModelManager.sharedManager
            let finalData = tools.objectWithDictionary(dict!, cls: UserHistoryModels.self) as? UserHistoryModels
            completion(finalData, nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["list":"\(UserHistoryModel.self)"]
    }
}





























