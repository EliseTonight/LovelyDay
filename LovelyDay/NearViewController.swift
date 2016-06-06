//
//  NearViewController.swift
//  LovelyDay
//
//  Created by Elise on 16/6/4.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit
//附带反转的附近
class NearViewController: UIViewController {
    
    
    var model:HomeModels? {
        didSet {
            self.nearMapView.model = model
        }
    }
    
    
    
    ///背景view
    private lazy var whiteBackView:UIView? = {
        let whiteBackView = UIView(frame: MainBounds)
        whiteBackView.backgroundColor = UIColor.whiteColor()
        return whiteBackView
    }()
    
    //主要的tableview
    private lazy var mainTableView:UITableView? = {
        let mainTableView = UITableView(frame: CGRectMake(0, 0, AppWidth, AppHeight - NavigationHeight), style: .Plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .None
        mainTableView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        return mainTableView
    }()
    //设置主要的tableView
    private func setMainTableView() {
        self.setTableRefreshAnimation(self, refreshingAction: #selector(NearViewController.loadData), gifFrame: CGRect(x: (AppWidth - RefreshImage_Width) * 0.5, y: 10, width: RefreshImage_Width, height: RefreshImage_Height), targetTableView: self.mainTableView!)
    }
    //下拉刷新动画
    private func setTableRefreshAnimation(refreshingTarget:AnyObject!,refreshingAction:Selector,gifFrame:CGRect,targetTableView:UITableView) {
        let header = LDRefreshHeader(refreshingTarget: refreshingTarget, refreshingAction: refreshingAction)
        header.gifView?.frame = gifFrame
        targetTableView.mj_header = header
    }
    //下拉加载数据动画，下拉会自动触发，已封装
    @objc private func loadData() {
        //闭包中使用self的引用会引起内存泄露，weak可以解决
        //另一种 ： 设置delegate时
        weak var selfRefer = self
        //模拟多线程的后台加载数据
        //设定时间
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC)))
        //延迟一段时间后执行，模拟加载时间，queue：提交到的队列
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            HomeModels.loadNearModels({ (data, error) in
                if data == nil {
                    SVProgressHUD.showErrorWithStatus("网络不给力")
                    selfRefer?.mainTableView?.mj_header.endRefreshing()
                }
                else {
                    selfRefer?.model = data
                    selfRefer?.mainTableView?.reloadData()
                    selfRefer?.mainTableView?.mj_header.endRefreshing()
                }
            })
        }
    }
    
    ///另一面的mapview
    private lazy var nearMapView:NearMapWithCollectionView = NearMapWithCollectionView(frame:CGRectMake(0, 0, AppWidth, AppHeight - NavigationHeight))
    
    ///右侧改变的button
    private lazy var rightItemButton:UIBarButtonItem = {
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: "list_1"), forState: .Normal)
        button.setImage(UIImage(named: "list_1"), forState: .Highlighted)
        button.frame = CGRectMake(0, 0, 50, 44)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        button.setImage(UIImage(named: "map_1"), forState: .Selected)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        button.addTarget(self, action: "rightButtonClick:", forControlEvents: .TouchUpInside)
        let barbutton = UIBarButtonItem(customView: button)
        return barbutton
    }()
    
    @objc private func rightButtonClick(sender:UIButton) {
        sender.selected = !sender.selected
        if sender.selected {
            UIView.transitionFromView(nearMapView, toView: mainTableView!, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: nil)
        } else {
            UIView.transitionFromView(mainTableView!, toView: nearMapView, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
        }
    }
    //分享
    private var shareView = ShareView.loadShareViewFromXib()
    //nearMapView最下面的view
    private lazy var nearBottomView:UIView? = {
        let nearBottomView = NearBottomView.loadNearBottomView()
        nearBottomView.frame = CGRect(x: 0, y: AppHeight - 50 - NavigationHeight, width: AppWidth, height: 50)
        weak var selfRef = self
        nearBottomView.delegate = selfRef
        return nearBottomView
    }()
    private func setUI() {
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "附近"
        self.setMainTableView()
        self.view.addSubview(whiteBackView!)
        self.whiteBackView?.addSubview(mainTableView!)
        self.whiteBackView?.addSubview(nearMapView)
        self.nearMapView.addSubview(nearBottomView!)
        self.nearMapView.selfVC = self
        self.navigationItem.rightBarButtonItem = rightItemButton
        
    }
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()

        self.mainTableView?.mj_header.beginRefreshing()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        nearMapView.clearDisk()
        nearMapView.showsUserLocation = false
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

extension NearViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.list?.count ?? 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        cell = HomeCell.loadHomeCellWithTableView(tableView)
        (cell as? HomeCell)?.model = self.model?.list![indexPath.row]
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = HomeDetailViewController()
        vc.model = self.model?.list![indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension NearViewController:NearBottomViewDelegate {
    func nearBottomView(shareViewDidClick view: UIView) {
        self.view.addSubview(shareView)
        shareView.shareVC = self
        shareView.shareButtonClick(CGRect(x: 0, y: AppHeight - 190 - NavigationHeight, width: AppWidth, height: 190))
    }
    func nearBottomView(goHereViewDidClick view: UIView) {
        
    }
    
}