//
//  FunModel.swift
//  LittleDay3.0
//
//  Created by Elise on 16/5/16.
//  Copyright © 2016年 Elise. All rights reserved.
// 好玩的model

import Foundation




///timeList
class TimeListModel:NSObject {
    ///美天开始的时间
    var start_time:String?
    ///美天结束的时间
    var end_time:String?
    ///开始日期
    var start_date:String?
    ///结束日期
    var end_date:String?
    ///每周几
    var weekdays:String?
}
///fun的时间Model
class DataModel:NSObject ,DictModelProtocol{
    ///时间列表
    var time_list:[TimeListModel]?

    static func customClassMapping() -> [String : String]? {
        return ["time_list": "\(TimeListModel.self)"]
    }
}

///单个的FunModel
class FunModel:NSObject,DictModelProtocol {
    ///标题
    var title:String?
    ///内容string
    var content:String?
    ///头部多张图片
    var imgs:[String]?
    ///活动类型，比如户外活动
    var tag:String?
    ///集合地
    var address:String?
    ///时间
    var date:DataModel?
    ///城市
    var city:String?
    ///集合地之后的括号
    var poi:String?
    
    static func customClassMapping() -> [String : String]? {
        return ["date":"\(DataModel.self)"]
    }
    
}


///全部的fun，model
class FunModels:NSObject,DictModelProtocol {
    ///头部
    var head:[HeadModel]?
    ///fun的全部
    var list:[FunModel]?
    
    //载入本地数据
    class func loadFunModels(_ completion:(_ data:FunModels?,_ error:NSError?) -> ()) {
        let path = Bundle.main.path(forResource: "FunRowData", ofType: nil)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        if data != nil {
            let dict = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
            let tools = DictModelManager.sharedManager
            let finalData = tools.objectWithDictionary(dict!, cls: FunModels.self) as? FunModels
            completion(finalData, nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["list":"\(FunModel.self)","head":"\(HeadModel.self)"]
    }
}



