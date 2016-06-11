//
//  MainDescoverViewController.swift
//  LittleDay3.0
//
//  Created by Elise on 16/5/17.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class MainDescoverViewController: MainViewController{

    
    var model:DescoverModels? {
        didSet {
            setHeadIcon(model)
        }
    }
    ///themeModel
    var themeModel:HomeModels?
    //搜索列表
    var searchResult:[HomeModel] = []
    //搜索结果
    private func searchFilter(keywords:String) {
        self.searchResult.removeAll(keepCapacity: true)
        self.searchResult = (self.themeModel?.list?.filter({ (singleHomeModel) -> Bool in
            return ((singleHomeModel.address?.containsString(keywords))! || (singleHomeModel.name?.containsString(keywords))! || (singleHomeModel.title?.containsString(keywords))!)
        }))!
    }
    
    //搜索条部分
    private lazy var topSearchVC:UISearchController? = {
        let topSearchVC = UISearchController(searchResultsController: nil)
        topSearchVC.searchBar.frame = CGRect(x: 0, y: 0, width: AppWidth, height: 50)
        topSearchVC.searchResultsUpdater = self
        topSearchVC.hidesNavigationBarDuringPresentation = true
        topSearchVC.hidesBottomBarWhenPushed = true
        topSearchVC.dimsBackgroundDuringPresentation = false
        topSearchVC.delegate = self
        topSearchVC.searchBar.backgroundColor = UIColor.clearColor()
        topSearchVC.searchBar.setBackgroundImage(UIImage(named:"searchBG"), forBarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
        let textField:UITextField = topSearchVC.searchBar.valueForKey("searchField") as! UITextField
        textField.frame = CGRect(x: 8, y: 8, width: AppWidth - 16, height: 34)
        textField.textAlignment = .Left
        textField.textColor = UIColor.darkGrayColor()
        textField.placeholder = "店名,地址,标题......"
        let image = UIImage(named: "zdsearch")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        textField.leftView = imageView
        topSearchVC.searchBar.setSearchFieldBackgroundImage(UIImage(named:"searchdi"), forState: UIControlState.Normal)
        return topSearchVC
    }()
    
    //头部承载全部的View
    private lazy var headView:UIView? = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: 100 + 100))
        return view
    }()
    //part1
    private lazy var firstPartView:UIView? = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: 100))
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    //part2
    private lazy var secondPartView:UIView? = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 100, width: AppWidth, height: 100)
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    private lazy var secondPartScrollView:UIScrollView? = {
        let view = UIScrollView(frame: CGRect(x: 0, y: 0, width: (AppWidth / 4) * 3, height: 100))
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    //设置头部全部
    private func setHeadView() {
        self.view?.addSubview(topSearchVC!.searchBar)
        self.headView?.addSubview(firstPartView!)
        self.headView?.addSubview(secondPartView!)
    }
    //在model之后设置头部图标
    private func setHeadIcon(model:DescoverModels?) {
        let firstPartIcons = model?.tags?.One
        let secondPartIcons = model?.tags?.Two
        weak var selfRef = self
        for i in 0..<(firstPartIcons?.count)! {
            let iconView = TopPartOneView.loadTopPartOneViewFromXib(CGFloat(i), ySet: 0)
            iconView.delegate = selfRef
            iconView.model = firstPartIcons![i]
            self.firstPartView?.addSubview(iconView)
        }
        self.secondPartScrollView?.contentSize = CGSize(width: (AppWidth / 4) * CGFloat((secondPartIcons?.count)!), height: 100)
        self.secondPartView?.addSubview(secondPartScrollView!)
        for i in 0..<(secondPartIcons?.count)! {
            let iconView = TopPartOneView.loadTopPartOneViewFromXib(CGFloat(i), ySet: 0)
            iconView.delegate = selfRef
            iconView.model = secondPartIcons![i]
            self.secondPartScrollView?.addSubview(iconView)
        }
        let moreView = TopPartOneView.loadTopPartOneViewFromXib(3, ySet: 0)
        moreView.delegate = selfRef
        moreView.modelSetAsMore("shopmore", id: 0, title: "更多")
        self.secondPartView?.addSubview(moreView)
    }
    
    
    //主要的tableview
    private lazy var mainTableView:UITableView? = {
        let mainTableView = UITableView(frame: CGRectMake(0, 50, AppWidth, AppHeight - NavigationHeight - TabBarHeight), style: .Plain)
        mainTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .None
        mainTableView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        return mainTableView
    }()
    //设置主要的tableView
    private func setMainTableView() {
        self.mainTableView?.tableHeaderView = self.headView
        self.setTableRefreshAnimation(self, refreshingAction: #selector(MainDescoverViewController.loadData), gifFrame: CGRect(x: (AppWidth - RefreshImage_Width) * 0.5, y: 10, width: RefreshImage_Width, height: RefreshImage_Height), targetTableView: self.mainTableView!)
        self.view.addSubview(mainTableView!)
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
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
        //延迟一段时间后执行，模拟加载时间，queue：提交到的队列
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            DescoverModels.loadDescoverModels ({ (data, error) -> () in
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
            HomeModels.loadThemeModels({ (data, error) -> () in
                selfRefer?.themeModel = data
            })
        }
    }
    
    
    //设置右侧Tabbar按钮与标题
    private var rightButton = UIButton()
    private func setRightButtonAndTitle() {
        rightButton = titleWithImageButton(frame: CGRectMake(0, 20, 40, 44))
        self.rightButton.setImage(UIImage(named: "near_1"), forState: .Normal)
        self.rightButton.setImage(UIImage(named: "near_1"), forState: UIControlState.Highlighted)
        self.rightButton.addTarget(self, action: "positionButtonClick:", forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    //定位
    @objc private func positionButtonClick(sender:UIButton) {
        let vc = NearViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //不设置这个会导致点击后searchbar移到顶部外面看不见,
        self.definesPresentationContext = true
        
        
        
        
        self.title = "找店"
        
        setRightButtonAndTitle()
        
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
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
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

extension MainDescoverViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        if self.topSearchVC!.active {
            cell = HomeCell.loadHomeCellWithTableView(tableView)
            (cell as? HomeCell)?.model = self.searchResult[indexPath.row]
        }
        else {
            cell = DescoverCell.loadDescoverCellWithTableView(tableView)
            (cell as? DescoverCell)?.model = self.model?.list?[indexPath.row]
        }
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 275
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //搜索的影响
        if self.topSearchVC!.active {
            return self.searchResult.count
        }
        return self.model?.list?.count ?? 0
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //搜索的影响
        if self.topSearchVC!.active {
            let vc = HomeDetailViewController()
            vc.model = self.searchResult[indexPath.row]
            vc.type = 1
            self.navigationController?.presentViewController(vc, animated: true, completion: nil)
        }
        else {
            let vc = ThemeViewController()
            vc.model = self.model?.list![indexPath.row]
            vc.themeModel = self.themeModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

///头部图标的代理
extension MainDescoverViewController:TopPartOneViewDelegate {
    ///应该根据id来获取数据的，，，目前只抓取了1个数据，作为通用，，这边只是判断一下是否是更多还是普通的TopPart，更多id为0
    func topPartOneView(selectedId id: Int?, didSeletedName name: String?) {
        if id == 0 {
            let vc = MoreViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let vc = TopDetailCommonViewController()
            vc.headTitle = name
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//搜索
extension MainDescoverViewController:UISearchResultsUpdating ,UISearchControllerDelegate{
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if var keyword = self.topSearchVC?.searchBar.text {
            //去除关键词中的各种形式编码的空格等
            keyword.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            self.searchFilter(keyword)
            self.mainTableView?.reloadData()
        }
    }
    func willPresentSearchController(searchController: UISearchController) {
        self.mainTableView?.tableHeaderView = nil
        self.mainTableView?.frame = CGRectMake(0, 50, AppWidth, AppHeight - NavigationHeight - TabBarHeight + 10)
    }
    func willDismissSearchController(searchController: UISearchController) {
        self.mainTableView?.tableHeaderView = self.headView
        self.mainTableView?.frame = CGRectMake(0, 50, AppWidth, AppHeight - NavigationHeight - TabBarHeight)
    }

}


















