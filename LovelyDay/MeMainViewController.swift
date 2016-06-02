//
//  MeMainViewController.swift
//  LittleDay3.0
//
//  Created by Elise on 16/5/17.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class MeMainViewController: UIViewController {
    
    
    
    var userModel:UserModels? {
        didSet {
            self.headView.model = userModel?.data
        }
    }
    var userHistoryModels:UserHistoryModels? {
        didSet {
            self.mainTableView?.reloadData()
        }
    }
    
    
    
    
    
    ///头部
    private var headView = MeHeadView.loadMeHeadViewFromXib()
    
    
    //主要的tableview
    private lazy var mainTableView:UITableView? = {
        let mainTableView = UITableView(frame: CGRectMake(0, 0, AppWidth, AppHeight - NavigationHeight - TabBarHeight), style: .Plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .None
        mainTableView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        mainTableView.contentInset = UIEdgeInsets(top: -200, left: 0, bottom: 0, right: 0)
        return mainTableView
    }()
    //设置主要的tableView
    private func setMainTableView() {
        self.headView.frame = CGRect(x: 0, y: 0, width: AppWidth, height: 480)
        self.mainTableView?.tableHeaderView = self.headView
        self.view.addSubview(mainTableView!)
    }
    
    private func getUserInfoData() {
        UserModels.loadUserModels { (data, error) in
            self.userModel = data
            
        }
        UserHistoryModels.loadUserHistoryModels { (data, error) in
            self.userHistoryModels = data
        }
    }
    
    //设置右侧Tabbar按钮与标题
    private var rightButton = UIButton()
    private func setRightButtonAndTitle() {
        rightButton = titleWithImageButton(frame: CGRectMake(0, 0, 40, 44))
        self.rightButton.setImage(UIImage(named: "pcenter_1"), forState: .Normal)
        self.rightButton.setImage(UIImage(named: "pcenter_1"), forState: UIControlState.Highlighted)
        self.rightButton.addTarget(self, action: "showUserInfo:", forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    //显示个人信息
    @objc private func showUserInfo(sender:UIButton) {
        let vc = UserInfoViewController()
        vc.model = self.userModel?.data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //设置左侧Tabbar按钮与标题
    private var leftButton = UIButton()
    private func setLeftButtonnAndTitle() {
        leftButton = titleWithImageButton(frame: CGRectMake(0, 0, 40, 44))
        self.leftButton.setImage(UIImage(named: "pmessage_1"), forState: .Normal)
        self.leftButton.setImage(UIImage(named: "pmessage_1"), forState: UIControlState.Highlighted)
        self.leftButton.addTarget(self, action: "messageButtonClick:", forControlEvents: .TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    @objc private func messageButtonClick(sender:UIButton) {
        
    }
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我的"
        
        getUserInfoData()
        
        setMainTableView()
        
        setRightButtonAndTitle()
        
        setLeftButtonnAndTitle()
        

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


extension MeMainViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userHistoryModels?.list?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell?
        cell = MeHistoryCell.loadMeHistoryCellWithTableView(tableView)
        (cell as? MeHistoryCell)?.model = self.userHistoryModels?.list![indexPath.row]
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeightForIndexPath(indexPath, cellContentViewWidth: AppWidth, tableView: tableView)
    }
}













