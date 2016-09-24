//
//  MainDayViewController.swift
//  LittleDay3.0
//
//  Created by Elise on 16/5/17.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class MainDayViewController: MainViewController {

    
    
    
    var model:HomeModels? {
        didSet {
            self.dayView?.model = model?.day
            self.autoScrollView?.model = model?.head
            
        }
    }
    
    
    
    //头部的model，在这里就加载了，
    var headDayModel:CommentModels? 
    
    
    
    //设置右侧Tabbar按钮与标题
    fileprivate var rightButton = UIButton()
    fileprivate func setRightButtonAndTitle() {
        self.navigationController?.title = "小日子"
        rightButton = titleWithImageButton(frame: CGRect(x: 0, y: 20, width: 40, height: 44))
        self.rightButton.setImage(UIImage(named: "rshops_1"), for: UIControlState())
        self.rightButton.setImage(UIImage(named: "rshops_2"), for: UIControlState.highlighted)
        self.rightButton.addTarget(self, action: #selector(MainDayViewController.pushRecommendView(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    @objc fileprivate func pushRecommendView(_ sender:UIButton) {
        let vc = RecommedOrSignViewController()
        vc.setInitData([7], type: 0, modelData: [nil])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //头部承载全部的View
    fileprivate lazy var headView:UIView? = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: 160 + 100 + 50))
        return view
    }()
    //part1
    fileprivate lazy var dayView:HeadDayView? = {
        let view = HeadDayView.loadHeadDayViewFromXib()
        view.frame = CGRect(x: 0, y: 0, width: AppWidth, height: 50)
        let tap = UITapGestureRecognizer(target: self, action: #selector(MainDayViewController.headDayTap))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        return view
    }()
    @objc fileprivate func headDayTap() {
        let vc = OneDayWordViewController()
        vc.model = self.headDayModel
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    //part2
    fileprivate lazy var autoScrollView:AutoScrollView? = {
        let view = AutoScrollView(frame: CGRect(x: 0, y: 50, width: AppWidth, height: 160))
        weak var selfRef = self
        view.delegate = selfRef
        return view
    }()
    //part3
    fileprivate lazy var srlView:SRLView? = {
        let view = SRLView.loadSRLViewFromXib()
        weak var selfRef = self
        view.delegate = selfRef
        view.frame = CGRect(x: 0, y: 210, width: AppWidth, height: 100)
        return view
    }()
    //设置头部全部
    fileprivate func setHeadView() {
        self.headView?.addSubview(dayView!)
        self.headView?.addSubview(autoScrollView!)
        self.headView?.addSubview(srlView!)
        
    }
    
    
    //主要的tableview
    fileprivate lazy var mainTableView:UITableView? = {
        let mainTableView = UITableView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight - NavigationHeight - TabBarHeight), style: .plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        mainTableView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        return mainTableView
    }()
    //设置主要的tableView
    fileprivate func setMainTableView() {
        self.mainTableView?.tableHeaderView = self.headView
        self.setTableRefreshAnimation(self, refreshingAction: #selector(MainDayViewController.loadData), gifFrame: CGRect(x: (AppWidth - RefreshImage_Width) * 0.5, y: 10, width: RefreshImage_Width, height: RefreshImage_Height), targetTableView: self.mainTableView!)
        self.view.addSubview(mainTableView!)
    }
    //下拉刷新动画
    fileprivate func setTableRefreshAnimation(_ refreshingTarget:AnyObject!,refreshingAction:Selector,gifFrame:CGRect,targetTableView:UITableView) {
        let header = LDRefreshHeader(refreshingTarget: refreshingTarget, refreshingAction: refreshingAction)
        header?.gifView?.frame = gifFrame
        targetTableView.mj_header = header
    }
    //下拉加载数据动画，下拉会自动触发，已封装
    func loadData() {
        //闭包中使用self的引用会引起内存泄露，weak可以解决
        //另一种 ： 设置delegate时
        weak var selfRefer = self
        //模拟多线程的后台加载数据
        //设定时间
        let time = DispatchTime.now() + Double(Int64(0.8 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        //延迟一段时间后执行，模拟加载时间，queue：提交到的队列
        DispatchQueue.main.asyncAfter(deadline: time) { () -> Void in
            HomeModels.loadHomeModels({ (data, error) -> () in
                if data == nil {
                    SVProgressHUD.showError(withStatus: "网络不给力")
                    selfRefer?.mainTableView?.mj_header.endRefreshing()
                    self.headView?.isHidden = false
                }
                else {
                    selfRefer?.model = data
                    selfRefer?.mainTableView?.reloadData()
                    selfRefer?.mainTableView?.mj_header.endRefreshing()
                    self.headView?.isHidden = false
                }
            })
            CommentModels.loadCommentModels({ (data, error) -> () in
                selfRefer?.headDayModel = data
            })
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "小日子"
        
        setRightButtonAndTitle()
        
        setHeadView()
        
        self.headView?.isHidden = true
        
        setMainTableView()
        
        self.mainTableView?.mj_header.beginRefreshing()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.autoScrollView?.startTimer()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.autoScrollView?.endTimer()
    }
    
    deinit {
        self.autoScrollView?.endTimer()
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

//tableview
extension MainDayViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        switch (self.model?.list![(indexPath as NSIndexPath).row].root_type)! {
        case "0":
            cell = HomeCell.loadHomeCellWithTableView(tableView)
            (cell as? HomeCell)?.model = self.model?.list![(indexPath as NSIndexPath).row]
        case "3":
            cell = MeiWenCell.loadMeiWenCellWithTableView(tableView)
            (cell as? MeiWenCell)?.model = self.model?.list![(indexPath as NSIndexPath).row]
        case "8":
            cell = HandcraftCell.loadHandcraftWithTableView(tableView)
            (cell as? HandcraftCell)?.model = self.model?.list![(indexPath as NSIndexPath).row]
        default:
            break
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.list?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (self.model?.list![(indexPath as NSIndexPath).row].root_type)! {
        case "0":
            return 300
        case "3":
            return 210
        case "8":
            return 240
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (self.model?.list![(indexPath as NSIndexPath).row].root_type)! {
        case "0":
            let vc = HomeDetailViewController()
            vc.model = self.model?.list?[(indexPath as NSIndexPath).row]
            self.navigationController?.pushViewController(vc, animated: true)
        case "3":
            let vc = AutoScrollDetailViewController()
            vc.model = self.model?.list?[(indexPath as NSIndexPath).row].url
            self.navigationController?.pushViewController(vc, animated: true)
        case "8":
            let vc = AutoScrollDetailViewController()
            vc.model = self.model?.list?[(indexPath as NSIndexPath).row].url
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }

    }
}

extension MainDayViewController:AutoScrollViewDelegate {
    func autoScrollViewView(_ autoHeadView: AutoScrollView, didSelectedAtIndex index: Int) {
        let vc = AutoScrollDetailViewController()
        vc.model = self.model?.head![index].url
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainDayViewController:SRLViewDelegate {
    func SRLViewLViewClick() {
        let vc = LViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func SRLViewRViewClick() {
        let vc = RViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func SRLViewSViewClick() {
        let vc = SViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}






