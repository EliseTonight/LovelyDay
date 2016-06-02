//
//  RViewController.swift
//  LovelyDay
//
//  Created by Elise on 16/5/20.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class RViewController: UIViewController {

    
    
    var model:ArticleModels? {
        didSet {
            
        }
    }
    
    
    
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
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1.2 * Double(NSEC_PER_SEC)))
        //延迟一段时间后执行，模拟加载时间，queue：提交到的队列
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            ArticleModels.loadArticleModels({ (data, error) -> () in
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

extension RViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.list?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell?
        cell = RViewCell.loadLViewCellWithTableView(tableView)
        (cell as? RViewCell)?.model = self.model?.list?[indexPath.row]
        return cell!
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = AutoScrollDetailViewController()
        vc.model = self.model?.list![indexPath.row].url
        self.navigationController?.pushViewController(vc, animated: true)
    }
}