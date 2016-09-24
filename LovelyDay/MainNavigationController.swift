//
//  MainNavigationController.swift
//  LittleDay3.0
//
//  Created by Elise on 16/5/17.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = nil
        // Do any additional setup after loading the view.
    }
    lazy var backButton:UIButton = {
        let backButton:UIButton = UIButton(type: .custom)
        backButton.setTitleColor(UIColor.black, for: UIControlState())
        backButton.setTitleColor(UIColor.gray, for: .highlighted)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        backButton.setImage(UIImage(named: "back_1"), for: UIControlState())
        backButton.setImage(UIImage(named: "back_2"), for: .highlighted)
        backButton.contentHorizontalAlignment = .left
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0)
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        let backButtonWidth: CGFloat = AppWidth > 375.0 ? 50 : 44
        backButton.frame = CGRect(x: 0, y: 0, width: backButtonWidth, height: 40)
        backButton.addTarget(self, action: "turnBack:", for: .touchUpInside)
        return backButton
    }()
    //override函数，简化所有Navigation的push，隐藏tabbar
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
//            let viewC = childViewControllers[0]
//            //改变左侧
//            if childViewControllers.count == 1 {
//                backButton.setTitle(viewC.tabBarItem.title, forState: .Normal)
//            }
//            else {
//                backButton.setTitle("返回", forState: .Normal)
//            }
            //初始化button
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
            //隐藏tabbar ,when push
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc fileprivate func turnBack(_ button:UIButton) {
        self.popViewController(animated: true)
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
