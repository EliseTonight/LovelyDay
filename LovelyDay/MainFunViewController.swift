//
//  MainFunViewController.swift
//  LittleDay3.0
//
//  Created by Elise on 16/5/17.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class MainFunViewController: MainViewController {

    
    
    
    var model:FunModels? {
        didSet {
            self.autoScrollView?.model = model?.head
        }
    }
    
    
    
    
    
    
    
    //头部承载全部的View
    private lazy var headView:UIView? = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: 170))
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    //part1
    private lazy var autoScrollView:AutoScrollView? = {
        let view = AutoScrollView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: 160))
        weak var selfRef = self
        view.delegate = selfRef
        return view
    }()
    //空白间隙part2
    private lazy var blankGap:UIView? = {
        let view = UIView(frame: CGRect(x: 0, y: 160, width: AppWidth, height: 10))
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    //设置头部全部
    private func setHeadView() {
        self.headView?.addSubview(autoScrollView!)
        self.headView?.addSubview(blankGap!)
    }
    
    
    //主要的tableview
    private lazy var mainTableView:UITableView? = {
        let mainTableView = UITableView(frame: CGRectMake(0, 0, AppWidth, AppHeight - NavigationHeight - TabBarHeight), style: .Plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .None
        mainTableView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        return mainTableView
    }()
    //设置主要的tableView
    private func setMainTableView() {
        self.mainTableView?.tableHeaderView = self.headView
        self.setTableRefreshAnimation(self, refreshingAction: "loadData", gifFrame: CGRect(x: (AppWidth - RefreshImage_Width) * 0.5, y: 10, width: RefreshImage_Width, height: RefreshImage_Height), targetTableView: self.mainTableView!)
        self.view.addSubview(mainTableView!)
    }
    //下拉刷新动画
    private func setTableRefreshAnimation(refreshingTarget:AnyObject!,refreshingAction:Selector,gifFrame:CGRect,targetTableView:UITableView) {
        let header = LDRefreshHeader(refreshingTarget: refreshingTarget, refreshingAction: refreshingAction)
        header.gifView?.frame = gifFrame
        targetTableView.mj_header = header
    }
    //下拉加载数据动画，下拉会自动触发，已封装
    func loadData() {
        //闭包中使用self的引用会引起内存泄露，weak可以解决
        //另一种 ： 设置delegate时
        weak var selfRefer = self
        //模拟多线程的后台加载数据
        //设定时间
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.8 * Double(NSEC_PER_SEC)))
        //延迟一段时间后执行，模拟加载时间，queue：提交到的队列
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            FunModels.loadFunModels ({ (data, error) -> () in
                if data == nil {
                    SVProgressHUD.showErrorWithStatus("网络不给力")
                    selfRefer?.mainTableView?.mj_header.endRefreshing()
                    self.headView?.hidden = false
                }
                else {
                    selfRefer?.model = data
                    selfRefer?.mainTableView?.reloadData()
                    selfRefer?.mainTableView?.mj_header.endRefreshing()
                    self.headView?.hidden = false
                }
            })
        }
    }
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "好玩"
        
        setHeadView()
        
        self.headView?.hidden = true
        
        setMainTableView()
        
        self.mainTableView?.mj_header.beginRefreshing()

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
extension MainFunViewController:AutoScrollViewDelegate {
    func autoScrollViewView(autoHeadView: AutoScrollView, didSelectedAtIndex index: Int) {
        let vc = AutoScrollDetailViewController()
        vc.model = self.model?.head![index].url
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainFunViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        cell = FunCell.loadFunCellWithTableView(tableView)
        (cell as? FunCell)?.model = self.model?.list?[indexPath.row]
        return cell!
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.list?.count ?? 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 330
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = FunDetailViewController()
        vc.model = self.model?.list![indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}