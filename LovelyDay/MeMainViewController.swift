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
    fileprivate var headView = MeHeadView.loadMeHeadViewFromXib()
    
    
    //主要的tableview
    fileprivate lazy var mainTableView:UITableView? = {
        let mainTableView = UITableView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight - NavigationHeight - TabBarHeight), style: .plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        mainTableView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        mainTableView.contentInset = UIEdgeInsets(top: -200, left: 0, bottom: 0, right: 0)
        return mainTableView
    }()
    //设置主要的tableView
    fileprivate func setMainTableView() {
        self.headView.frame = CGRect(x: 0, y: 0, width: AppWidth, height: 480)
        self.mainTableView?.tableHeaderView = self.headView
        self.view.addSubview(mainTableView!)
    }
    
    fileprivate func getUserInfoData() {
        UserModels.loadUserModels { (data, error) in
            
            self.userModel = data
            
        }
        UserHistoryModels.loadUserHistoryModels { (data, error) in
            self.userHistoryModels = data
        }
    }
    
    //设置右侧Tabbar按钮与标题
    fileprivate var rightButton = UIButton()
    fileprivate func setRightButtonAndTitle() {
        rightButton = titleWithImageButton(frame: CGRect(x: 0, y: 0, width: 40, height: 44))
        self.rightButton.setImage(UIImage(named: "pcenter_1"), for: UIControlState())
        self.rightButton.setImage(UIImage(named: "pcenter_1"), for: UIControlState.highlighted)
        self.rightButton.addTarget(self, action: "showUserInfo:", for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    //显示个人信息
    @objc fileprivate func showUserInfo(_ sender:UIButton) {
        let vc = UserInfoViewController()
        vc.model = self.userModel?.data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //设置左侧Tabbar按钮与标题
    fileprivate var leftButton = UIButton()
    fileprivate func setLeftButtonnAndTitle() {
        leftButton = titleWithImageButton(frame: CGRect(x: 0, y: 0, width: 40, height: 44))
        self.leftButton.setImage(UIImage(named: "pmessage_1"), for: UIControlState())
        self.leftButton.setImage(UIImage(named: "pmessage_1"), for: UIControlState.highlighted)
        self.leftButton.addTarget(self, action: "messageButtonClick:", for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    @objc fileprivate func messageButtonClick(_ sender:UIButton) {
        
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userHistoryModels?.list?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell?
        cell = MeHistoryCell.loadMeHistoryCellWithTableView(tableView)
        (cell as? MeHistoryCell)?.model = self.userHistoryModels?.list![(indexPath as NSIndexPath).row]
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight(for: indexPath, cellContentViewWidth: AppWidth, tableView: tableView)
    }
}













