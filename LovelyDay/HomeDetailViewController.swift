//
//  HomeDetailViewController.swift
//  LovelyDay
//
//  Created by Elise on 16/5/20.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class HomeDetailViewController: UIViewController {

    
    
    //用以判断是哪个push的,,1为present
    var type:Int = 0 {
        didSet {
            
        }
    }
    
    
    var model:HomeModel? {
        didSet {
            let newStr = NSMutableString.changeHeigthAndWidthWithSrting(NSMutableString(string: (model?.content!)!))
            self.mainWebView?.loadHTMLString(newStr as String, baseURL: nil)
            self.topImageView.setImageWithURL(NSURL(string: (model?.img)!))
            self.headTitleView.model = model
        }
    }
    func setGradientNavigationBarHidden() {
        self.gradientNavigationView?.hidden = true
    }
    
    //渐变的头部
    private lazy var backButton = UIButton()
    private lazy var likeButton = UIButton()
    private lazy var shareButton = UIButton()
    private lazy var gradientNavigationView:UIView? = {
        let gradientNavigationView = UIView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: NavigationHeight))
        gradientNavigationView.backgroundColor = UIColor.whiteColor()
        gradientNavigationView.alpha = 0.0
        return gradientNavigationView
    }()
    private func setNavigationButton() {
        self.view.addSubview(gradientNavigationView!)
        self.setButton(backButton, frame: CGRectMake(-7, 20, 44, 44), image: "back_3", highLightImage: "back_3", selectedImage: nil, action: "backButtonClick:")
        self.setButton(likeButton, frame: CGRectMake(AppWidth - 105, 20, 44, 44), image: "titlelike_3", highLightImage: "titlelike_3", selectedImage: "listlike_2", action: "likeButtonClick:")
        self.setButton(shareButton, frame: CGRectMake(AppWidth - 54, 20, 44, 44), image: "titleshare_3", highLightImage: "titleshare_3", selectedImage: nil, action: "shareButtonClick:")
    }
    @objc private func backButtonClick(sender:UIButton) {
        if self.type == 1 {
            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            self.navigationController?.popViewControllerAnimated(true)
        }
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
    
    //头部拉升的图片与 头部标题等
    private lazy var topImageView: UIImageView = {
        let image = UIImageView(frame: CGRectMake(0, 0, AppWidth, 180))
        image.image = UIImage(named: "quesheng")
        image.contentMode = .ScaleToFill
        image.clipsToBounds = true
        return image
    }()
    private lazy var headTitleView:HomeDetailHeadView = {
        let view = HomeDetailHeadView.loadHomeDetailHeadViewFromXib()
        return view
    }()
    private func setHeadView() {
        self.topImageView.frame = CGRectMake(0, -340, AppWidth, 180)
        self.headTitleView.frame = CGRectMake(0, -160, AppWidth, 160)
        self.mainWebView?.scrollView.addSubview(topImageView)
        self.mainWebView?.scrollView.addSubview(headTitleView)
    }
    
    //webView
    private lazy var mainWebView:UIWebView? = {
        var webView = UIWebView(frame: MainBounds)
        webView.delegate = self
        webView.scrollView.delegate = self
        webView.backgroundColor = UIColor.whiteColor()
        webView.scrollView.contentInset = UIEdgeInsets(top: 340 - 20, left: 0, bottom: 0, right: 0)
        webView.scrollView.setContentOffset(CGPoint(x: 0, y: -340 + 20), animated: false)
        webView.scrollView.showsHorizontalScrollIndicator = false
        return webView
    }()
    private func setMainWebView() {
        self.view.addSubview(mainWebView!)
    }
    
    //底部
    private lazy var footView:RecordView? = {
        let footView = RecordView.loadRecordViewFromXib()
        weak var selfRef = self
        footView.delegate = selfRef
        return footView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMainWebView()
        
        setHeadView()
        setNavigationButton()
        
        ///添加定位监视器
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showLocationMapView:", name: Elise_ShopLocationNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    //进入定位view
    @objc private func showLocationMapView(notice:NSNotification) {
        let vc = ShopLocationViewController()
        vc.model = self.model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
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

extension HomeDetailViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offY = scrollView.contentOffset.y
        if offY < -340 {
            self.topImageView.frame = CGRectMake((offY + 340) / 3, offY, AppWidth - (offY + 340) / 1.5, 180 - offY - 340)
        }
        if offY >= (-160 - NavigationHeight) {
            self.backButton.setImage(UIImage(named: "back_1"), forState: UIControlState.Normal)
            self.likeButton.setImage(UIImage(named: "titlelike_1"), forState: UIControlState.Normal)
            self.shareButton.setImage(UIImage(named: "titleshare_1"), forState: UIControlState.Normal)
        }
        else {
            self.backButton.setImage(UIImage(named: "back_3"), forState: UIControlState.Normal)
            self.likeButton.setImage(UIImage(named: "titlelike_3"), forState: UIControlState.Normal)
            self.shareButton.setImage(UIImage(named: "titleshare_3"), forState: UIControlState.Normal)
        }
        if offY > -340 {
            self.gradientNavigationView?.alpha = (offY + 340) / (180 - NavigationHeight)
        }
        else {
            self.gradientNavigationView?.alpha = 0
        }
        
    }
}
//在载入webview之后动态的添加末尾
extension HomeDetailViewController:UIWebViewDelegate {
    func webViewDidFinishLoad(webView: UIWebView) {
        //Tips,,,图标数是动态的
        let iconNum = self.model?.tips?.count ?? 0
        if iconNum != 0 {
            let tipHeadView = TipHeadView.loadTipHeadViewFromXib()
            tipHeadView.frame = CGRect(x: 0, y: webView.scrollView.contentSize.height, width: AppWidth, height: 100)
            webView.scrollView.addSubview(tipHeadView)
            webView.scrollView.contentSize.height = webView.scrollView.contentSize.height + 100
            
            let tipsScrollView = UIScrollView(frame: CGRect(x: 0, y: webView.scrollView.contentSize.height, width: AppWidth, height: 110))
            tipsScrollView.backgroundColor = UIColor.whiteColor()
            tipsScrollView.showsVerticalScrollIndicator = false
            if iconNum <= 4 {
                tipsScrollView.contentSize = CGSize(width: AppWidth, height: 110)
            }
            else {
                tipsScrollView.contentSize = CGSize(width: (AppWidth / 4) * CGFloat(iconNum), height: 110)
            }
            for i in 0..<iconNum {
                let tipView = TipSignView.loadTipSignViewFromXib(tipModel: (self.model?.tips![i])!)
                tipView.frame = CGRectMake((AppWidth / 4) * CGFloat(i), 0, AppWidth / 4, 80)
                tipsScrollView.addSubview(tipView)
            }
            webView.scrollView.addSubview(tipsScrollView)
            webView.scrollView.contentSize.height = webView.scrollView.contentSize.height + 110
        }
        //人均消费
        if self.model?.per != nil {
            if (self.model?.per)! != "" {
                let view = StoreInfoView.loadStoreInfoViewFromXib((self.model?.per)!, type: 1)
                view.frame = CGRect(x: 0, y: webView.scrollView.contentSize.height, width: AppWidth, height: 80)
                webView.scrollView.addSubview(view)
                webView.scrollView.contentSize.height = webView.scrollView.contentSize.height + 80
            }
        }
        //营业时间
        if self.model?.open_time != nil {
            if (self.model?.open_time)! != "" {
                let view = StoreInfoView.loadStoreInfoViewFromXib((self.model?.open_time)!, type: 2)
                view.frame = CGRect(x: 0, y: webView.scrollView.contentSize.height, width: AppWidth, height: 80)
                webView.scrollView.addSubview(view)
                webView.scrollView.contentSize.height = webView.scrollView.contentSize.height + 80
            }
        }
        //店铺电话
        if self.model?.phone != nil {
            if (self.model?.phone)! != "" {
                let view = StoreInfoView.loadStoreInfoViewFromXib((self.model?.phone)!, type: 3)
                view.frame = CGRect(x: 0, y: webView.scrollView.contentSize.height, width: AppWidth, height: 80)
                webView.scrollView.addSubview(view)
                webView.scrollView.contentSize.height = webView.scrollView.contentSize.height + 80
            }
        }
        //店铺地址
        if self.model?.address != nil {
            if (self.model?.address)! != "" {
                let view = StoreInfoView.loadStoreInfoViewFromXib((self.model?.address)!, type: 4)
                view.frame = CGRect(x: 0, y: webView.scrollView.contentSize.height, width: AppWidth, height: 80)
                webView.scrollView.addSubview(view)
                webView.scrollView.contentSize.height = webView.scrollView.contentSize.height + 80
            }
        }
        //最底部的
        footView!.frame = CGRect(x: 0, y: webView.scrollView.contentSize.height, width: AppWidth, height: 196)
        webView.scrollView.addSubview(footView!)
        webView.scrollView.contentSize.height = webView.scrollView.contentSize.height + 196
    }
}

extension HomeDetailViewController:RecordViewDelegate {
    func recordViewSignButton() {
        let vc = RecommedOrSignViewController()
        vc.setInitData([7], type: 1, modelData: [nil])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}










