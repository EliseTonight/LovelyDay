//
//  AutoScrollView.swift
//  LittleDay3.0
//
//  Created by Elise on 16/5/17.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

//自动滚动的头部
class AutoScrollView: UIView {
    
    //当前的图片在数组中的位置
    fileprivate var currentIndex:Int = 0 {
        didSet {
            if currentIndex > imageArray.count - 1 {
                currentIndex = 0
            }
            if currentIndex < 0 {
                currentIndex = imageArray.count - 1
            }
            delegate?.autoScrollViewImageDidChange?(currentIndex: currentIndex)
        }
    }
    
    var delegate:AutoScrollViewDelegate?
    
    //图片的数组
    fileprivate var imageArray:[String] = []
    //三个图片的String
    fileprivate var imageThreeArray:[String?] = [nil,nil,nil]
    //三个图片
    fileprivate var leftImage:UIImageView?
    fileprivate var currentImage:UIImageView?
    fileprivate var rightImage:UIImageView?
    
    //使page不可见
    func hiddenPageController() {
        self.pageControl?.isHidden = true
    }
    func showPageController() {
        self.pageControl?.isHidden = false
    }
    func getCurrentIndex() -> Int {
        return currentIndex
    }
    
    //自动计时器,时间不能相同，
    fileprivate var timer:Timer?
    func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: "autoChangeImage", userInfo: nil, repeats: true)
        
    }
    func endTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    @objc fileprivate func autoChangeImage() {
        self.currentIndex = self.currentIndex + 1
        UIView.animate(withDuration: 3.0, animations: { () -> Void in
            self.headScrollView?.setContentOffset(CGPoint(x: self.frame.width * 2, y: 0), animated: false)
            }, completion: { (success) -> Void in
                self.reloadImage()
                self.headScrollView?.setContentOffset(CGPoint(x: self.frame.width, y: 0), animated: false)
        })
    }
    
    var model:[HeadModel]? {
        didSet {
            let pictureNum = model?.count
            if pictureNum == 1 {
                self.headScrollView?.isScrollEnabled = false
            }
            self.pageControl?.numberOfPages = pictureNum!
            for i in 0..<pictureNum! {
                self.imageArray.append(model![i].img!)
            }
            reloadImage()
        }
    }
    var modelStringInterface:[String]? {
        didSet {
            let pictureNum = modelStringInterface?.count
            if pictureNum == 1 {
                self.headScrollView?.isScrollEnabled = false
            }
            self.pageControl?.numberOfPages = pictureNum!
            for i in 0..<pictureNum! {
                self.imageArray.append(modelStringInterface![i])
            }
            reloadImage()
        }
    }
    
    //重新设置三个imageView的图片
    func reloadImage() {
        
        self.pageControl?.currentPage = currentIndex
        self.getCurrentImageArray(currentIndex)
        leftImage?.sd_setImage(with: URL(string: imageThreeArray[0]!), placeholderImage: UIImage(named: "quesheng"))
        currentImage?.sd_setImage(with: URL(string: imageThreeArray[1]!), placeholderImage: UIImage(named: "quesheng"))
        rightImage?.sd_setImage(with: URL(string: imageThreeArray[2]!), placeholderImage: UIImage(named: "quesheng"))
    }
    
    
    ///获取当前应该设置的三个Image的String
    fileprivate func getCurrentImageArray(_ currentIndex:Int) {
        var left = currentIndex - 1
        var right = currentIndex + 1
        if left < 0 {
            left = imageArray.count - 1
        }
        if right >= imageArray.count {
            right = 0
        }
        imageThreeArray[0] = imageArray[left]
        imageThreeArray[1] = imageArray[currentIndex]
        imageThreeArray[2] = imageArray[right]
    }
    
    fileprivate func setSingleImageView(_ num:CGFloat) -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: num * self.bounds.width, y: 0, width: self.bounds.width, height: self.frame.height))
        let tap = UITapGestureRecognizer(target: self, action: "imageClick:")
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        return imageView
    }
    fileprivate func initImage() {
        leftImage = self.setSingleImageView(0)
        currentImage =  self.setSingleImageView(1)
        rightImage = self.setSingleImageView(2)
        self.headScrollView?.addSubview(leftImage!)
        self.headScrollView?.addSubview(currentImage!)
        self.headScrollView?.addSubview(rightImage!)
    }
    
    func imageClick(_ tap:UITapGestureRecognizer) {
        if delegate != nil {
            delegate?.autoScrollViewView(self, didSelectedAtIndex: currentIndex)
        }
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.headScrollView?.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.pageControl?.frame = CGRect(x: 0, y: self.frame.height * 0.9,  width: self.frame.width, height: self.frame.height * 0.1)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(headScrollView!)
        self.addSubview(pageControl!)
        self.initImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var headScrollView:UIScrollView? = {
        let headScrollView = UIScrollView()
        headScrollView.delegate = self
        headScrollView.contentSize = CGSize(width: self.frame.width * 3.0, height: self.frame.height)
        headScrollView.showsVerticalScrollIndicator = false
        headScrollView.showsHorizontalScrollIndicator = false
        headScrollView.isPagingEnabled = true
        headScrollView.contentOffset = CGPoint(x: self.frame.width, y: 0);
        return headScrollView
    }()
    fileprivate lazy var pageControl:UIPageControl? = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.hidesForSinglePage = true
        return pageControl
    }()
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
//协议
@objc protocol AutoScrollViewDelegate {
    func autoScrollViewView(_ autoHeadView:AutoScrollView,didSelectedAtIndex index: Int)
    @objc optional func autoScrollViewImageDidChange(currentIndex index: Int)
}
//滚动减速时就开始重置缓冲池
extension AutoScrollView:UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offSetX = scrollView.contentOffset.x
        if offSetX < (self.frame.width * 0.7) {
            currentIndex = currentIndex - 1
            self.reloadImage()
            self.headScrollView?.setContentOffset(CGPoint(x: self.frame.width, y: 0), animated: false)
        }
        else if offSetX > (self.frame.width * 1.3){
            currentIndex = currentIndex + 1
            self.reloadImage()
            self.headScrollView?.setContentOffset(CGPoint(x: self.frame.width, y: 0), animated: false)
        }
        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.endTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.startTimer()
    }
    
    
    
}
