//
//  PublicProperties.swift
//  LittleDay3.0
//
//  Created by Elise on 16/5/16.
//  Copyright © 2016年 Elise. All rights reserved.
//   公共属性

import Foundation
import UIKit



public let NavigationHeight:CGFloat = 64
public let TabBarHeight:CGFloat = 49
public let MainBounds:CGRect = UIScreen.main.bounds
public let AppWidth:CGFloat = UIScreen.main.bounds.size.width
public let AppHeight:CGFloat = UIScreen.main.bounds.size.height
//刷新的动画页面
public let RefreshImage_Height: CGFloat = 40
public let RefreshImage_Width: CGFloat = 35
//tabbarItem颜色
public let TabBarColor:UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)

/// cache文件路径
public let cachesPath: String = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!

///高德地图
public let GaoDeApi = "598b0ac3dc76e7ca417728c067b0645c"



//Nsnotication

//显示主要view
public let Elise_ShowMainView = "Elise_ShowMainView"
//当前选择城市
public let Elise_Current_SelectedCity = "Elise_Current_SelectedCity"
//key for 返回后的View
public let Elise_CurrentCityChange_Notification = "Elise_CurrentCityChange_Notification"
///签到，推荐的文字修改
public let Elise_WordsChange = "Elise_WordsChange"
///点击定位
public let Elise_ShopLocationNotification = "Elise_ShopLocationNotification"
