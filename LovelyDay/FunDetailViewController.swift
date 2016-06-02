//
//  FunDetailViewController.swift
//  LovelyDay
//
//  Created by Elise on 16/5/28.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class FunDetailViewController: UIViewController {
    
    
    
    var model:FunModel? {
        didSet {
            let newStr = NSMutableString.changeHeigthAndWidthWithSrting(NSMutableString(string: (model?.content!)!))
            self.mainWebView?.loadHTMLString(newStr as String, baseURL: nil)
            self.topImageView?.modelStringInterface = model?.imgs
            self.headTitleView.model = model
        }
    }
    
    
    
    //渐变的头部与固定的底部
    private lazy var backButton = UIButton()
    private lazy var likeButton = UIButton()
    private lazy var shareButton = UIButton()
    private lazy var gradientNavigationView:UIView? = {
        let gradientNavigationView = UIView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: NavigationHeight))
        gradientNavigationView.backgroundColor = UIColor.whiteColor()
        gradientNavigationView.alpha = 0.0
        return gradientNavigationView
    }()
    private lazy var funBottomView:FunDetailBottomView? = {
        let view = FunDetailBottomView.loadFunDetailBottomViewFromXib()
        view.frame = CGRect(x: 0, y: AppHeight - 50, width: AppWidth, height: 50)
        return view
    }()
    private func setNavigationButton() {
        self.view.addSubview(gradientNavigationView!)
        self.view.addSubview(funBottomView!)
        self.setButton(backButton, frame: CGRectMake(-7, 20, 44, 44), image: "back_3", highLightImage: "back_3", selectedImage: nil, action: "backButtonClick:")
        self.setButton(likeButton, frame: CGRectMake(AppWidth - 105, 20, 44, 44), image: "titlelike_3", highLightImage: "titlelike_3", selectedImage: "listlike_2", action: "likeButtonClick:")
        self.setButton(shareButton, frame: CGRectMake(AppWidth - 54, 20, 44, 44), image: "titleshare_3", highLightImage: "titleshare_3", selectedImage: nil, action: "shareButtonClick:")
    }
    @objc private func backButtonClick(sender:UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @objc private func likeButtonClick(sender:UIButton) {
        sender.selected = !sender.selected
    }
    private var shareView = ShareView.loadShareViewFromXib()
    @objc private func shareButtonClick(sender:UIButton) {
        self.view.addSubview(shareView)
        shareView.shareVC = self
        shareView.shareButtonClick(CGRect(x: 0, y: AppHeight - 190, width: AppWidth, height: 190))
    }
    
    //头部拉升的多个图片与 头部标题等
    private lazy var topImageView: AutoScrollView? = {
        let view = AutoScrollView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: 180))
        weak var selfRef = self
        view.delegate = selfRef
        view.endTimer()
        return view
    }()
    //覆盖的头部image，用于拉伸时显示
    private lazy var topScaleImageView:UIImageView? = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: 180))
        view.contentMode = .ScaleToFill
        view.clipsToBounds = true
        return view
    }()
    private lazy var headTitleView:FunDetailTopView = {
        let view = FunDetailTopView.loadFunDetailTopViewFromXib()
        return view
    }()
    private func setHeadView() {
        self.topImageView!.frame = CGRectMake(0, -360, AppWidth, 180)
        self.topScaleImageView?.frame = CGRectMake(0, -360, AppWidth, 180)
        self.headTitleView.frame = CGRectMake(0, -180, AppWidth, 180)
        self.mainWebView?.scrollView.addSubview(topImageView!)
        self.mainWebView?.scrollView.addSubview(topScaleImageView!)
        self.mainWebView?.scrollView.addSubview(headTitleView)
        self.topScaleImageView?.sd_setImageWithURL(NSURL(string: (self.model?.imgs![0])!))
        self.topScaleImageView?.hidden =  true
    }
    
    //webView
    private lazy var mainWebView:UIWebView? = {
        var webView = UIWebView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight - 50))
        webView.delegate = self
        webView.scrollView.delegate = self
        webView.backgroundColor = UIColor.whiteColor()
        webView.scrollView.contentInset = UIEdgeInsets(top: 360 - 20, left: 0, bottom: 0, right: 0)
        webView.scrollView.setContentOffset(CGPoint(x: 0, y: -360 + 20), animated: false)
        webView.scrollView.showsHorizontalScrollIndicator = false
        return webView
    }()
    private func setMainWebView() {
        self.view.addSubview(mainWebView!)
    }
    
    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setMainWebView()
        
        setHeadView()
        
        setNavigationButton()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
extension FunDetailViewController:AutoScrollViewDelegate {
    func autoScrollViewView(autoHeadView: AutoScrollView, didSelectedAtIndex index: Int) {
        
    }
    func autoScrollViewImageDidChange(currentIndex index: Int) {
        self.topScaleImageView?.sd_setImageWithURL(NSURL(string: (self.model?.imgs![index])!))
    }
}
extension FunDetailViewController:UIWebViewDelegate {
    
}
extension FunDetailViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offY = scrollView.contentOffset.y
        if offY < -360 {
            self.topScaleImageView?.hidden = false
            self.topScaleImageView?.frame = CGRectMake((offY + 360) / 3, offY, AppWidth - (offY + 360) / 1.5, 180 - offY - 360)
        }
        if offY >= (-180 - NavigationHeight) {
            self.backButton.setImage(UIImage(named: "back_1"), forState: UIControlState.Normal)
            self.likeButton.setImage(UIImage(named: "titlelike_1"), forState: UIControlState.Normal)
            self.shareButton.setImage(UIImage(named: "titleshare_1"), forState: UIControlState.Normal)
        }
        else {
            self.backButton.setImage(UIImage(named: "back_3"), forState: UIControlState.Normal)
            self.likeButton.setImage(UIImage(named: "titlelike_3"), forState: UIControlState.Normal)
            self.shareButton.setImage(UIImage(named: "titleshare_3"), forState: UIControlState.Normal)
        }
        if offY >= -360 {
            self.topScaleImageView?.hidden = true
            self.gradientNavigationView?.alpha = (offY + 360) / (180 - NavigationHeight)
        }
        else {
            self.gradientNavigationView?.alpha = 0
        }
    }
}