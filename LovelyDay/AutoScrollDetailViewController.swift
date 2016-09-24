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
            self.webView?.loadRequest(URLRequest(url: URL(string: (model!))!))
        }
    }
    
    //承载的WebView
    fileprivate lazy var webView:UIWebView? = {
        let view = UIWebView(frame: MainBounds)
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        view.delegate = self
        return view
    }()
    
    //设置右边的Button
    fileprivate lazy var likeButton:UIButton = {
        let likeButton:UIButton = UIButton(type: .custom)
        likeButton.setImage(UIImage(named: "titlelike_1"), for: UIControlState())
        likeButton.setImage(UIImage(named: "listlike_2"), for: UIControlState.selected)
        let backButtonWidth: CGFloat = AppWidth > 375.0 ? 50 : 44
        likeButton.frame = CGRect(x: 0, y: 0, width: backButtonWidth, height: 44)
        likeButton.addTarget(self, action: "likeButtonClick:", for: .touchUpInside)
        return likeButton
    }()
    fileprivate lazy var shareButton:UIButton = {
        let shareButton:UIButton = UIButton(type: .custom)
        shareButton.setImage(UIImage(named: "titleshare_1"), for: UIControlState())
        shareButton.setImage(UIImage(named: "titleshare_1"), for: UIControlState.highlighted)
        let backButtonWidth: CGFloat = AppWidth > 375.0 ? 50 : 44
        shareButton.frame = CGRect(x: 0, y: 0, width: backButtonWidth, height: 44)
        shareButton.addTarget(self, action: "shareButtonClick:", for: .touchUpInside)
        return shareButton
    }()
    fileprivate func setRightBarButton() {
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: self.shareButton),UIBarButtonItem(customView: likeButton)]
    }
    @objc func likeButtonClick(_ sender:UIButton) {
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
        sender.isSelected = !sender.isSelected
        
       
    }
    //share
    fileprivate var shareView = ShareView.loadShareViewFromXib()
    @objc func shareButtonClick(_ sender:UIButton) {
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
