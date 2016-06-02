//
//  CommentModels.swift
//  LovelyDay
//
//  Created by Elise on 16/5/19.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation




class CommentModel:NSObject {
    ///内容
    var content:String?
    ///时间
    var date:String?
    ///头像
    var head_photo:String?
    /// 用户名
    var name:String?
    ///用户id
    
}

class CommentModels:NSObject,DictModelProtocol {
    
    ///评论列表
    var list:[CommentModel]?
    
    //载入本地数据
    class func loadCommentModels(completion:(data:CommentModels?,error:NSError?) -> ()) {
        let path = NSBundle.mainBundle().pathForResource("Comment", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            let tools = DictModelManager.sharedManager
            let finalData = tools.objectWithDictionary(dict!, cls: CommentModels.self) as? CommentModels
            completion(data: finalData, error: nil)
        }
    }
    
    
    
    
    
    
    
    
    static func customClassMapping() -> [String : String]? {
        return ["list":"\(CommentModel.self)"]
    }
    
    
}