//
//  HomeModel.swift
//  LittleDay3.0
//
//  Created by Elise on 16/5/16.
//  Copyright © 2016年 Elise. All rights reserved.
// 主页的model


import Foundation


///spaceModel
class SpaceModel:NSObject {
    ///类别，比如 画室
    var name:String?
    ///图标
    var icon_map:String?
    ///
}
///TipModel
class TipModel:NSObject {
    ///tip类别，比如wifi
    var name:String?
    ///tip对应图标
    var img:String?
}
///头部循环图片model，，，在好玩页面也有一个头部
class HeadModel:NSObject {
    ///主要的图片
    var img:String?
    ///主要标题
    var title:String?
    ///主要内容
    var url:String?
}
///时间的头部
class DayModel:NSObject {
    ///主要的时间
    var date:String?
    ///标题
    var title:String?
}
///主要的model
class HomeModel:NSObject ,DictModelProtocol{
    ///决定了cell的Type，，0为带图片的普通cell，3为文字的美文，8为匠人'志.
    var root_type:String?
    
    //有关type0
    ///主要的背景图片
    var img:String?
    ///电话
    var phone:String?
    ///城市
    var city:String?
    ///主要的标题,type8的个人签名,type3的主标题，，theme：副标题
    var title:String?
    ///店铺地址
    var address:String?
    ///店铺名称，type8：匠人名字,,theme:标题
    var name:String?
    ///space，店铺类别
    var space:SpaceModel?
    ///tip，即wifi什么的
    var tips:[TipModel]?
    ///人均消费
    var per:String?
    ///id
    var id:Int = -1
    ///店铺id
    var shop_id:Int = -1
    ///开放时间
    var open_time:String?
    ///type0的主要内容
    var content:String?
    //有关type8
    /// 头像
    var head_photo:String?
    ///内容,,type3的内容
    var url:String?
    /// 定位经纬度
    var position:String?
    
    ///theme的cell的一段文字
    var detail:String?
    
    
    static func customClassMapping() -> [String : String]? {
        return ["space":"\(SpaceModel.self)" , "tips":"\(TipModel.self)"]
    }
    
}

///总的主页model
class HomeModels:NSObject,DictModelProtocol {
    
    ///主要的
    var list:[HomeModel]?
    //头部循环图片
    var head:[HeadModel]?
    ///day头部
    var day:DayModel?
    
    
    //载入本地数据，，主页的
    class func loadHomeModels(completion:(data:HomeModels?,error:NSError?) -> ()) {
        let path = NSBundle.mainBundle().pathForResource("HomeRowData", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            let tools = DictModelManager.sharedManager
            let finalData = tools.objectWithDictionary(dict!, cls: HomeModels.self) as? HomeModels
            completion(data: finalData, error: nil)
        }
    }
    ///载入本地数据，找店的
    class func loadThemeModels(completion:(data:HomeModels?,error:NSError?) -> ()) {
        let path = NSBundle.mainBundle().pathForResource("themes", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            let tools = DictModelManager.sharedManager
            let finalData = tools.objectWithDictionary(dict!, cls: HomeModels.self) as? HomeModels
            completion(data: finalData, error: nil)
        }
    }
    ///载入本地数据，TopPartTheme的model
    class func loadMoreThemeModels(completion:(data:HomeModels?,error:NSError?) -> ()) {
        let path = NSBundle.mainBundle().pathForResource("MoreThemeData", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            let tools = DictModelManager.sharedManager
            let finalData = tools.objectWithDictionary(dict!, cls: HomeModels.self) as? HomeModels
            completion(data: finalData, error: nil)
        }
    }
    ///载入本底数据，找店，附近定位的数据
    class func loadNearModels(completion:(data:HomeModels?,error:NSError?) -> ()) {
        let path = NSBundle.mainBundle().pathForResource("NearData", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            let tools = DictModelManager.sharedManager
            let finalData = tools.objectWithDictionary(dict!, cls: HomeModels.self) as? HomeModels
            completion(data: finalData, error: nil)
        }
    }
    static func customClassMapping() -> [String : String]? {
        return ["list":"\(HomeModel.self)","head":"\(HeadModel.self)","day":"\(DayModel.self)"]
    }
    
}





