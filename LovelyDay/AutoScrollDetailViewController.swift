//
//  AutoScrollDetailViewController.swift
//  LovelyDay
//
//  Created by Elise on 16/5/19.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class AutoScrollDetailViewController: UIViewController {
    
    
    
    var model:String? {
        didSet {
            self.webView?.loadRequest(NSURLRequest(URL: NSURL(string: (model!))!))
        }
    }
    
    //承载的WebView
    private lazy var webView:UIWebView? = {
        let view = UIWebView(frame: MainBounds)
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        view.delegate = self
        return view
    }()
    
    //设置右边的Button
    private lazy var likeButton:UIButton = {
        let likeButton:UIButton = UIButton(type: .Custom)
        likeButton.setImage(UIImage(named: "titlelike_1"), forState: .Normal)
        likeButton.setImage(UIImage(named: "listlike_2"), forState: UIControlState.Selected)
        let backButtonWidth: CGFloat = AppWidth > 375.0 ? 50 : 44
        likeButton.frame = CGRectMake(0, 0, backButtonWidth, 44)
        likeButton.addTarget(self, action: "likeButtonClick:", forControlEvents: .TouchUpInside)
        return likeButton
    }()
    private lazy var shareButton:UIButton = {
        let shareButton:UIButton = UIButton(type: .Custom)
        shareButton.setImage(UIImage(named: "titleshare_1"), forState: .Normal)
        shareButton.setImage(UIImage(named: "titleshare_1"), forState: UIControlState.Highlighted)
        let backButtonWidth: CGFloat = AppWidth > 375.0 ? 50 : 44
        shareButton.frame = CGRectMake(0, 0, backButtonWidth, 44)
        shareButton.addTarget(self, action: "shareButtonClick:", forControlEvents: .TouchUpInside)
        return shareButton
    }()
    private func setRightBarButton() {
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: self.shareButton),UIBarButtonItem(customView: likeButton)]
    }
    @objc func likeButtonClick(sender:UIButton) {
        //likeButton的动画，但是x轴会变化，，烦。。。
        
        
//        let scale:CGFloat = 1.2
//        UIView.animateWithDuration(0.1, animations: { () -> Void in
//            sender.transform = CGAffineTransformMakeScale(1.1, 1.1)
//            }) { (success) -> Void in
//                sender.selected = !sender.selected
//                UIView.animateWithDuration(0.1, animations: { () -> Void in
//                    sender.transform = CGAffineTransformMakeScale(1.0, 1.0)
//                })
//        }
        sender.selected = !sender.selected
        
       
    }
    //share
    private var shareView = ShareView.loadShareViewFromXib()
    @objc func shareButtonClick(sender:UIButton) {
        self.view.addSubview(shareView)
        shareView.shareVC = self
        shareView.shareButtonClick(CGRect(x: 0, y: AppHeight - 190 - NavigationHeight, width: AppWidth, height: 190))
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setRightBarButton()
        
        
        self.view.addSubview(webView!)
        // Do any additional setup after loading the view.
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
extension AutoScrollDetailViewController:UIWebViewDelegate {
    
}