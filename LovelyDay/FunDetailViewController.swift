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
    fileprivate lazy var backButton = UIButton()
    fileprivate lazy var likeButton = UIButton()
    fileprivate lazy var shareButton = UIButton()
    fileprivate lazy var gradientNavigationView:UIView? = {
        let gradientNavigationView = UIView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: NavigationHeight))
        gradientNavigationView.backgroundColor = UIColor.white
        gradientNavigationView.alpha = 0.0
        return gradientNavigationView
    }()
    fileprivate lazy var funBottomView:FunDetailBottomView? = {
        let view = FunDetailBottomView.loadFunDetailBottomViewFromXib()
        view.frame = CGRect(x: 0, y: AppHeight - 50, width: AppWidth, height: 50)
        return view
    }()
    fileprivate func setNavigationButton() {
        self.view.addSubview(gradientNavigationView!)
        self.view.addSubview(funBottomView!)
        self.setButton(backButton, frame: CGRect(x: -7, y: 20, width: 44, height: 44), image: "back_3", highLightImage: "back_3", selectedImage: nil, action: "backButtonClick:")
        self.setButton(likeButton, frame: CGRect(x: AppWidth - 105, y: 20, width: 44, height: 44), image: "titlelike_3", highLightImage: "titlelike_3", selectedImage: "listlike_2", action: "likeButtonClick:")
        self.setButton(shareButton, frame: CGRect(x: AppWidth - 54, y: 20, width: 44, height: 44), image: "titleshare_3", highLightImage: "titleshare_3", selectedImage: nil, action: "shareButtonClick:")
    }
    @objc fileprivate func backButtonClick(_ sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc fileprivate func likeButtonClick(_ sender:UIButton) {
        sender.isSelected = !sender.isSelected
    }
    fileprivate var shareView = ShareView.loadShareViewFromXib()
    @objc fileprivate func shareButtonClick(_ sender:UIButton) {
        self.view.addSubview(shareView)
        shareView.shareVC = self
        shareView.shareButtonClick(CGRect(x: 0, y: AppHeight - 190, width: AppWidth, height: 190))
    }
    
    //头部拉升的多个图片与 头部标题等
    fileprivate lazy var topImageView: AutoScrollView? = {
        let view = AutoScrollView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: 180))
        weak var selfRef = self
        view.delegate = selfRef
        view.endTimer()
        return view
    }()
    //覆盖的头部image，用于拉伸时显示
    fileprivate lazy var topScaleImageView:UIImageView? = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: 180))
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        return view
    }()
    fileprivate lazy var headTitleView:FunDetailTopView = {
        let view = FunDetailTopView.loadFunDetailTopViewFromXib()
        return view
    }()
    fileprivate func setHeadView() {
        self.topImageView!.frame = CGRect(x: 0, y: -360, width: AppWidth, height: 180)
        self.topScaleImageView?.frame = CGRect(x: 0, y: -360, width: AppWidth, height: 180)
        self.headTitleView.frame = CGRect(x: 0, y: -180, width: AppWidth, height: 180)
        self.mainWebView?.scrollView.addSubview(topImageView!)
        self.mainWebView?.scrollView.addSubview(topScaleImageView!)
        self.mainWebView?.scrollView.addSubview(headTitleView)
        self.topScaleImageView?.sd_setImage(with: URL(string: (self.model?.imgs![0])!))
        self.topScaleImageView?.isHidden =  true
    }
    
    //webView
    fileprivate lazy var mainWebView:UIWebView? = {
        var webView = UIWebView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight - 50))
        webView.delegate = self
        webView.scrollView.delegate = self
        webView.backgroundColor = UIColor.white
        webView.scrollView.contentInset = UIEdgeInsets(top: 360 - 20, left: 0, bottom: 0, right: 0)
        webView.scrollView.setContentOffset(CGPoint(x: 0, y: -360 + 20), animated: false)
        webView.scrollView.showsHorizontalScrollIndicator = false
        return webView
    }()
    fileprivate func setMainWebView() {
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
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
    func autoScrollViewView(_ autoHeadView: AutoScrollView, didSelectedAtIndex index: Int) {
        
    }
    func autoScrollViewImageDidChange(currentIndex index: Int) {
        self.topScaleImageView?.sd_setImage(with: URL(string: (self.model?.imgs![index])!))
    }
}
extension FunDetailViewController:UIWebViewDelegate {
    
}
extension FunDetailViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offY = scrollView.contentOffset.y
        if offY < -360 {
            self.topScaleImageView?.isHidden = false
            self.topScaleImageView?.frame = CGRect(x: (offY + 360) / 3, y: offY, width: AppWidth - (offY + 360) / 1.5, height: 180 - offY - 360)
        }
        if offY >= (-180 - NavigationHeight) {
            self.backButton.setImage(UIImage(named: "back_1"), for: UIControlState())
            self.likeButton.setImage(UIImage(named: "titlelike_1"), for: UIControlState())
            self.shareButton.setImage(UIImage(named: "titleshare_1"), for: UIControlState())
        }
        else {
            self.backButton.setImage(UIImage(named: "back_3"), for: UIControlState())
            self.likeButton.setImage(UIImage(named: "titlelike_3"), for: UIControlState())
            self.shareButton.setImage(UIImage(named: "titleshare_3"), for: UIControlState())
        }
        if offY >= -360 {
            self.topScaleImageView?.isHidden = true
            self.gradientNavigationView?.alpha = (offY + 360) / (180 - NavigationHeight)
        }
        else {
            self.gradientNavigationView?.alpha = 0
        }
    }
}
