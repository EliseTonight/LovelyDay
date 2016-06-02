//
//  ArticleModels.swift
//  LovelyDay
//
//  Created by Elise on 16/5/20.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation


class ArticleModel:NSObject {
    ///来源
    var from:String?
    ///标题
    var title:String?
    ///图片
    var img:String?
    /// 具体内容
    var url:String?
}

class ArticleModels:NSObject,DictModelProtocol {
    
    ///所有
    var list:[ArticleModel]?
    
    //载入本地数据
    class func loadArticleModels(completion:(data:ArticleModels?,error:NSError?) -> ()) {
        let path = NSBundle.mainBundle().pathForResource("RViewData", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            let tools = DictModelManager.sharedManager
            let finalData = tools.objectWithDictionary(dict!, cls: ArticleModels.self) as? ArticleModels
            completion(data: finalData, error: nil)
        }
    }
    static func customClassMapping() -> [String : String]? {
        return ["list":"\(ArticleModel.self)"]
    }
    
    
    
    
    
    
}