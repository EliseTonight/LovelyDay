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
    fileprivate lazy var whiteBackView:UIView? = {
        let whiteBackView = UIView(frame: MainBounds)
        whiteBackView.backgroundColor = UIColor.white
        return whiteBackView
    }()
    
    //主要的tableview
    fileprivate lazy var mainTableView:UITableView? = {
        let mainTableView = UITableView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight - NavigationHeight), style: .plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        mainTableView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        return mainTableView
    }()
    //设置主要的tableView
    fileprivate func setMainTableView() {
        self.setTableRefreshAnimation(self, refreshingAction: #selector(NearViewController.loadData), gifFrame: CGRect(x: (AppWidth - RefreshImage_Width) * 0.5, y: 10, width: RefreshImage_Width, height: RefreshImage_Height), targetTableView: self.mainTableView!)
    }
    //下拉刷新动画
    fileprivate func setTableRefreshAnimation(_ refreshingTarget:AnyObject!,refreshingAction:Selector,gifFrame:CGRect,targetTableView:UITableView) {
        let header = LDRefreshHeader(refreshingTarget: refreshingTarget, refreshingAction: refreshingAction)
        header?.gifView?.frame = gifFrame
        targetTableView.mj_header = header
    }
    //下拉加载数据动画，下拉会自动触发，已封装
    @objc fileprivate func loadData() {
        //闭包中使用self的引用会引起内存泄露，weak可以解决
        //另一种 ： 设置delegate时
        weak var selfRefer = self
        //模拟多线程的后台加载数据
        //设定时间
        let time = DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        //延迟一段时间后执行，模拟加载时间，queue：提交到的队列
        DispatchQueue.main.asyncAfter(deadline: time) { () -> Void in
            HomeModels.loadNearModels({ (data, error) in
                if data == nil {
                    SVProgressHUD.showError(withStatus: "网络不给力")
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
    fileprivate lazy var nearMapView:NearMapWithCollectionView = NearMapWithCollectionView(frame:CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight - NavigationHeight))
    
    ///右侧改变的button
    fileprivate lazy var rightItemButton:UIBarButtonItem = {
        let button: UIButton = UIButton(type: .custom)
        button.setImage(UIImage(named: "list_1"), for: UIControlState())
        button.setImage(UIImage(named: "list_1"), for: .highlighted)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 44)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        button.setImage(UIImage(named: "map_1"), for: .selected)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        button.addTarget(self, action: #selector(NearViewController.rightButtonClick(_:)), for: .touchUpInside)
        let barbutton = UIBarButtonItem(customView: button)
        return barbutton
    }()
    
    @objc fileprivate func rightButtonClick(_ sender:UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            UIView.transition(from: nearMapView, to: mainTableView!, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromLeft, completion: nil)
        } else {
            UIView.transition(from: mainTableView!, to: nearMapView, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
        }
    }
    //分享
    fileprivate var shareView = ShareView.loadShareViewFromXib()
    //nearMapView最下面的view
    fileprivate lazy var nearBottomView:UIView? = {
        let nearBottomView = NearBottomView.loadNearBottomView()
        nearBottomView.frame = CGRect(x: 0, y: AppHeight - 50 - NavigationHeight, width: AppWidth, height: 50)
        weak var selfRef = self
        nearBottomView.delegate = selfRef
        return nearBottomView
    }()
    fileprivate func setUI() {
        self.view.backgroundColor = UIColor.white
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
        nearMapView.isShowsUserLocation = false
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.list?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        cell = HomeCell.loadHomeCellWithTableView(tableView)
        (cell as? HomeCell)?.model = self.model?.list![(indexPath as NSIndexPath).row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HomeDetailViewController()
        vc.model = self.model?.list![(indexPath as NSIndexPath).row]
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
