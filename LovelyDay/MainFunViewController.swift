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
    fileprivate lazy var headView:UIView? = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: 170))
        view.backgroundColor = UIColor.white
        return view
    }()
    //part1
    fileprivate lazy var autoScrollView:AutoScrollView? = {
        let view = AutoScrollView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: 160))
        weak var selfRef = self
        view.delegate = selfRef
        return view
    }()
    //空白间隙part2
    fileprivate lazy var blankGap:UIView? = {
        let view = UIView(frame: CGRect(x: 0, y: 160, width: AppWidth, height: 10))
        view.backgroundColor = UIColor.white
        return view
    }()
    //设置头部全部
    fileprivate func setHeadView() {
        self.headView?.addSubview(autoScrollView!)
        self.headView?.addSubview(blankGap!)
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
        self.setTableRefreshAnimation(self, refreshingAction: "loadData", gifFrame: CGRect(x: (AppWidth - RefreshImage_Width) * 0.5, y: 10, width: RefreshImage_Width, height: RefreshImage_Height), targetTableView: self.mainTableView!)
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
            FunModels.loadFunModels ({ (data, error) -> () in
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
        }
    }
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "好玩"
        
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
    func autoScrollViewView(_ autoHeadView: AutoScrollView, didSelectedAtIndex index: Int) {
        let vc = AutoScrollDetailViewController()
        vc.model = self.model?.head![index].url
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainFunViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        cell = FunCell.loadFunCellWithTableView(tableView)
        (cell as? FunCell)?.model = self.model?.list?[(indexPath as NSIndexPath).row]
        return cell!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.list?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FunDetailViewController()
        vc.model = self.model?.list![(indexPath as NSIndexPath).row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
