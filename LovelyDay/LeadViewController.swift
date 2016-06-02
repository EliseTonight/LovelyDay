//
//  LeadViewController.swift
//  LittleDay3.0
//
//  Created by Elise on 16/5/17.
//  Copyright © 2016年 Elise. All rights reserved.
//  登录引导页面，图片的渐变

import UIKit


class LeadViewController: UIViewController {
    @IBOutlet weak var backgroundImageViews: UIImageView!
    @IBOutlet weak var secondBackImageView: UIImageView!
    @IBOutlet weak var threeBackImageView: UIImageView!
    @IBOutlet weak var wechatLoginButton: UIButton! {
        didSet {
            wechatLoginButton.addTarget(self, action: "showMainView", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    @IBOutlet weak var weiboLoginButton: UIButton! {
        didSet {
            weiboLoginButton.addTarget(self, action: "showMainView", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    @IBOutlet weak var enterButton: UIButton! {
        didSet {
            enterButton.addTarget(self, action: "showMainView", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    
    //作为动画开始的标记，
    private var startChangeSign:Int = 0 {
        didSet {
            self.changeBackWithAnimation()
        }
    }
    
    //三个图片的循环播放，，有好方法请告诉我，谢谢
    @objc private func changeBackWithAnimation() {
        UIView.animateWithDuration(4.0) { () -> Void in
            self.backgroundImageViews.alpha = 0
            self.secondBackImageView.alpha = 1
            
        }
        self.performSelector("secondChange", withObject: nil, afterDelay: 4.0)
    }
    @objc private func secondChange() {
        UIView.animateWithDuration(4.0) { () -> Void in
            self.secondBackImageView.alpha = 0
            self.threeBackImageView.alpha = 1
        }
        self.performSelector("threeChange", withObject: nil, afterDelay: 4.0)
    }
    @objc private func threeChange() {
        UIView.animateWithDuration(4.0) { () -> Void in
            self.threeBackImageView.alpha = 0
            self.backgroundImageViews.alpha = 1
        }
        self.performSelector("restart", withObject: nil, afterDelay: 4.0)
    }
    @objc private func restart() {
        self.startChangeSign = self.startChangeSign + 1
    }
    
    
    //通知显示主界面
    @objc private func showMainView() {
        NSNotificationCenter.defaultCenter().postNotificationName(Elise_ShowMainView, object: nil, userInfo: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startChangeSign = 1

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    //销毁计时器
//    deinit {
//        self.time?.invalidate()
//        self.time = nil
//        
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
