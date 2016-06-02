//
//  MainTabBarViewController.swift
//  LittleDay3.0
//
//  Created by Elise on 16/5/16.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

import UIKit
//主页面
class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAllTabBarItem()
        self.setValue(MainTabBar(), forKey: "tabBar")
        
        // Do any additional setup after loading the view.
    }
    private func setAllTabBarItem() {
        //小日子
        setTabBar(vc: MainDayViewController(), title: "小日子", imageName: "life_1", imageSelectedName: "life_2")
        //好玩
        setTabBar(vc: MainFunViewController(), title: "好玩", imageName: "fun_1", imageSelectedName: "fun_2")
        //找店
        setTabBar(vc: MainDescoverViewController(), title: "找店", imageName: "fstore_1", imageSelectedName: "fstore_2")
        //我的
        setTabBar(vc: MeMainViewController(), title: "我的", imageName: "my_1", imageSelectedName: "my_2")
    }
    //每一个页面的初始化
    private func setTabBar(vc vc:UIViewController,title:String,imageName:String,imageSelectedName:String) {
        let selectImage = UIImage(named: imageSelectedName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let normalImage = UIImage(named: imageName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        vc.tabBarItem = UITabBarItem()
        vc.tabBarItem.title = title
        vc.tabBarItem.image = normalImage
        vc.tabBarItem.selectedImage = selectImage
        vc.view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        let navigationVC = MainNavigationController(rootViewController:vc)
        addChildViewController(navigationVC)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
//mainTabBar的初始化
class MainTabBar:UITabBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translucent = false
        self.backgroundImage = UIImage(named: "tabbar")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




