//
//  AppDelegate.swift
//  LovelyDay3.0
//
//  Created by Elise on 16/5/16.
//  Copyright © 2016年 Elise. All rights reserved.
//  本项目为小日子3.01版本，， Swift2.2与Xcode7.3.1制作，by FurElise
//  其中有些部分选自 小日子2.0，by 维尼的小熊
//  由于我仍然在学习中，不足与改进之处还希望能够联系我。
//  github地址 https://github.com/EliseTonight/LovelyDay
//  相关博客地址

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        setWindow()
        setAppAppearance()
        
        //获取name信号后执行,,KVO(Key-Value Observing)
        NotificationCenter.default.addObserver(self, selector: "showMainView", name: NSNotification.Name(rawValue: Elise_ShowMainView), object: nil)
        
        
        //添加icon 3d Touch
        let firstItemIcon:UIApplicationShortcutIcon = UIApplicationShortcutIcon(type: .share)
        let firstItem = UIMutableApplicationShortcutItem(type: "1", localizedTitle: "分享", localizedSubtitle: nil, icon: firstItemIcon, userInfo: nil)
        
        let firstItemIcon1:UIApplicationShortcutIcon = UIApplicationShortcutIcon(type: .compose)
        let firstItem1 = UIMutableApplicationShortcutItem(type: "2", localizedTitle: "编辑", localizedSubtitle: nil, icon: firstItemIcon1, userInfo: nil)
        
        
        application.shortcutItems = [firstItem,firstItem1]
        
        // Override point for customization after application launch.
        return true
    }
    
    
    fileprivate func setWindow() {
        self.window = UIWindow(frame: MainBounds)
        self.window?.rootViewController = getFirstView()
        //添加view至窗口
        self.window?.makeKeyAndVisible()
    }
    
    fileprivate func getFirstView() -> UIViewController? {
        let view = LeadViewController()
        return view
    }
    fileprivate func setLocationInit() {
        LocationManager.sharedUserInfoManager.startUserlocation()
        AMapServices.shared().apiKey = GaoDeApi
    }
    
    
    //设置App公共外表
    fileprivate func setAppAppearance() {
        //设置tabbarItem的外表
        let itemAppearance = UITabBarItem.appearance()
        itemAppearance.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.black,NSFontAttributeName:UIFont.systemFont(ofSize: 12)], for: .selected)
        itemAppearance.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.gray, NSFontAttributeName : UIFont.systemFont(ofSize: 12)], for: UIControlState())
        //设置Navigation的外表
        let navigationAppearance = UINavigationBar.appearance()
        //Navigation半透明设置,半透明下也可以由数据，故会导致View的Frame错误
        
        navigationAppearance.isTranslucent = false
        navigationAppearance.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 18),NSForegroundColorAttributeName:UIColor.black]
        //设置item
        let barItemAppearance = UIBarButtonItem.appearance()
        barItemAppearance.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 16),NSForegroundColorAttributeName:UIColor.black], for: UIControlState())
    }
    
    
    /**
     3D Touch 跳转
     
     - parameter application:       application
     - parameter shortcutItem:      item
     - parameter completionHandler: handler
     */
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        completionHandler(handledShortCutItem)
        
    }
    
    func handleShortCutItem(_ shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        
        if shortcutItem.type == "1" { //分享
            
            let mainView = MainTabBarController()
            self.window?.rootViewController = mainView
            //添加view至窗口
            self.window?.makeKeyAndVisible()
            handled = true
            
        }
        
        if shortcutItem.type == "2" { //编辑
            
            let mainView = MainTabBarController()
            self.window?.rootViewController = mainView
            //添加view至窗口
            self.window?.makeKeyAndVisible()
            handled = true
            
        }
        return handled
    }
    
    
    @objc fileprivate func showMainView() {
        let mainView = MainTabBarController()
        self.window?.rootViewController = mainView
        self.setLocationInit()
//        let navigationView = mainView.viewControllers![0] as? MainNavigationController
//        (navigationView?.viewControllers[0] as! MainViewController)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

