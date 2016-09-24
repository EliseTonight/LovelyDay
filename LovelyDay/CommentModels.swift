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
    class func loadCommentModels(_ completion:(_ data:CommentModels?,_ error:NSError?) -> ()) {
        let path = Bundle.main.path(forResource: "Comment", ofType: nil)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        if data != nil {
            let dict = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
            let tools = DictModelManager.sharedManager
            let finalData = tools.objectWithDictionary(dict!, cls: CommentModels.self) as? CommentModels
            completion(finalData, nil)
        }
    }
    
    
    
    
    
    
    
    
    static func customClassMapping() -> [String : String]? {
        return ["list":"\(CommentModel.self)"]
    }
    
    
}
