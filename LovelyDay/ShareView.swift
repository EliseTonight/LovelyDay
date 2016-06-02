//
//  ShareView.swift
//  LovelyDay
//
//  Created by Elise on 16/5/19.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class ShareView: UIView {
    
    @IBOutlet weak var friendButton: UIButton!
    @IBOutlet weak var wechatButton: UIButton!
    @IBOutlet weak var weiboButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var backButton: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "dismissShareView")
            backButton.addGestureRecognizer(tap)
            backButton.userInteractionEnabled = true
        }
    }
    
    weak var shareVC:UIViewController?
    
    
    
    
    
    //黑色覆盖View
    private lazy var blackMainView:UIView? = {
        let view = UIView(frame: MainBounds)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        let tap = UITapGestureRecognizer(target: self, action: "dismissShareView")
        view.userInteractionEnabled = true
        view.addGestureRecognizer(tap)
        return view
    }()
    private lazy var blackSecondView:UIView? = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: 44))
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        let tap = UITapGestureRecognizer(target: self, action: "dismissShareView")
        view.userInteractionEnabled = true
        view.addGestureRecognizer(tap)
        return view
    }()
    
    
    
    
    ///显示ShareView
    @objc private func showShareView(rect:CGRect) {
        self.superview?.insertSubview(blackMainView!, belowSubview: self)
        self.shareVC?.navigationController?.navigationBar.addSubview(blackSecondView!)
        UIView.animateWithDuration(0.4) { () -> Void in
            self.frame = rect
        }
    }
    @objc private func dismissShareView() {
        self.blackMainView?.removeFromSuperview()
        self.blackSecondView?.removeFromSuperview()
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.frame = CGRectMake(0, AppHeight, AppWidth, 215)
            }) { (success) -> Void in
                self.removeFromSuperview()
        }
    }
    func shareButtonClick(rect:CGRect) {
        self.showShareView(rect)
    }
    
    class func loadShareViewFromXib() -> ShareView {
        let view = NSBundle.mainBundle().loadNibNamed("ShareView", owner: nil, options: nil).last as! ShareView
        view.frame = CGRect(x: 0, y: AppHeight, width: AppWidth, height: 190)
        return view
    }
    
    
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
protocol ShareViewDelegate {
    
}
