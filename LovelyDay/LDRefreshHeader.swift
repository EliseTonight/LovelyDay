//
//  LDRefreshHeader.swift
//  LittleDay
//
//  Created by Elise on 16/3/17.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit
//自定义的刷新控件，，by维尼的小熊
class LDRefreshHeader: MJRefreshGifHeader {

    
    //初始化
    override func prepare() {
        super.prepare()
        //刷新时间的Label
        stateLabel?.hidden = true
        lastUpdatedTimeLabel?.hidden = true
        //闲置的状态
        let staticImages = NSMutableArray()
        let staticImage = UIImage(named: "wnx00")
        staticImages.addObject(staticImage!)
        setImages(staticImages as [AnyObject], forState: MJRefreshState.Idle)
    
        //松开可以刷新的状态
        let readyRefreshImages = NSMutableArray()
        let readyRefreshImage = UIImage(named: "wnx00")
        readyRefreshImages.addObject(readyRefreshImage!)
        setImages(readyRefreshImages as [AnyObject], forState: MJRefreshState.Pulling)
        
        //刷新的状态
        let refreshImages = NSMutableArray()
        for i in 0...92 {
            //string format 模式匹配,,,d 十进制数
            let refreshImage = UIImage(named: String(format: "wnx%02d",i))
            refreshImages.addObject(refreshImage!)
        }
        setImages(refreshImages as [AnyObject], forState: MJRefreshState.Refreshing)
        
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
