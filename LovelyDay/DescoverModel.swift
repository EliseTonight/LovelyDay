//
//  DescoverModel.swift
//  LovelyDay
//
//  Created by Elise on 16/5/29.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation



class DescoverTopIconModel:NSObject {
    ///图标
    var icon:String?
    ///id
    var id:Int = -1
    ///标题
    var name:String?
}

class DescoverTopIconModels:NSObject,DictModelProtocol {
    ///第二行
    var Two:[DescoverTopIconModel]?
    ///第一行
    var One:[DescoverTopIconModel]?
    
    static func customClassMapping() -> [String : String]? {
        return ["Two":"\(DescoverTopIconModel.self)","One":"\(DescoverTopIconModel.self)"]
    }
}

class DescoverModel:NSObject {
    ///标题
    var title:String?
    ///内容头部
    var content:String?
    ///主要图片
    var img:String?
    ///tag
    var tag:String?
    ///url
    var theme_url:String?
    ///起始时间
    var start_date:String?
    ///结束时间
    var end_date:String?
    ///url
    var url:String?
}
class DescoverModels:NSObject,DictModelProtocol {
    ///list
    var list:[DescoverModel]?
    ///头部模块
    var tags:DescoverTopIconModels?
    
    //载入本地数据
    class func loadDescoverModels(completion:(data:DescoverModels?,error:NSError?) -> ()) {
        let path = NSBundle.mainBundle().pathForResource("DescoverData", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            let tools = DictModelManager.sharedManager
            let finalData = tools.objectWithDictionary(dict!, cls: DescoverModels.self) as? DescoverModels
            completion(data: finalData, error: nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["list":"\(DescoverModel.self)","tags":"\(DescoverTopIconModels.self)"]
    }
}





///更多单一的model
class MoreCollectModel:NSObject {
    ///id
    var id:Int = -1
    ///名字
    var name:String?
    ///名字旁小图标
    var icon:String?
    ///图片
    var img:String?
}
///更多model
class MoreCollectModels:NSObject,DictModelProtocol {
    ///list
    var list:[MoreCollectModel]?
    
    //载入本地数据
    class func loadMoreCollectModels(completion:(data:MoreCollectModels?,error:NSError?) -> ()) {
        let path = NSBundle.mainBundle().pathForResource("moreData", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            let tools = DictModelManager.sharedManager
            let finalData = tools.objectWithDictionary(dict!, cls: MoreCollectModels.self) as? MoreCollectModels
            completion(data: finalData, error: nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["list":"\(MoreCollectModel.self)"]
    }

}















