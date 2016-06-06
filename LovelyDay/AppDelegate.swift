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


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        setWindow()
        setAppAppearance()
        
        //获取name信号后执行,,KVO(Key-Value Observing)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showMainView", name: Elise_ShowMainView, object: nil)
        
        
        //添加icon 3d Touch
        let firstItemIcon:UIApplicationShortcutIcon = UIApplicationShortcutIcon(type: .Share)
        let firstItem = UIMutableApplicationShortcutItem(type: "1", localizedTitle: "分享", localizedSubtitle: nil, icon: firstItemIcon, userInfo: nil)
        
        let firstItemIcon1:UIApplicationShortcutIcon = UIApplicationShortcutIcon(type: .Compose)
        let firstItem1 = UIMutableApplicationShortcutItem(type: "2", localizedTitle: "编辑", localizedSubtitle: nil, icon: firstItemIcon1, userInfo: nil)
        
        
        application.shortcutItems = [firstItem,firstItem1]
        
        // Override point for customization after application launch.
        return true
    }
    
    
    private func setWindow() {
        self.window = UIWindow(frame: MainBounds)
        self.window?.rootViewController = getFirstView()
        //添加view至窗口
        self.window?.makeKeyAndVisible()
    }
    
    private func getFirstView() -> UIViewController? {
        let view = LeadViewController()
        return view
    }
    private func setLocationInit() {
        LocationManager.sharedUserInfoManager.startUserlocation()
        AMapServices.sharedServices().apiKey = GaoDeApi
    }
    
    
    //设置App公共外表
    private func setAppAppearance() {
        //设置tabbarItem的外表
        let itemAppearance = UITabBarItem.appearance()
        itemAppearance.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.blackColor(),NSFontAttributeName:UIFont.systemFontOfSize(12)], forState: .Selected)
        itemAppearance.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.grayColor(), NSFontAttributeName : UIFont.systemFontOfSize(12)], forState: .Normal)
        //设置Navigation的外表
        let navigationAppearance = UINavigationBar.appearance()
        //Navigation半透明设置,半透明下也可以由数据，故会导致View的Frame错误
        
        navigationAppearance.translucent = false
        navigationAppearance.titleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(18),NSForegroundColorAttributeName:UIColor.blackColor()]
        //设置item
        let barItemAppearance = UIBarButtonItem.appearance()
        barItemAppearance.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFontOfSize(16),NSForegroundColorAttributeName:UIColor.blackColor()], forState: .Normal)
    }
    
    
    /**
     3D Touch 跳转
     
     - parameter application:       application
     - parameter shortcutItem:      item
     - parameter completionHandler: handler
     */
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        completionHandler(handledShortCutItem)
        
    }
    
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
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
    
    
    @objc private func showMainView() {
        let mainView = MainTabBarController()
        self.window?.rootViewController = mainView
        self.setLocationInit()
//        let navigationView = mainView.viewControllers![0] as? MainNavigationController
//        (navigationView?.viewControllers[0] as! MainViewController)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

