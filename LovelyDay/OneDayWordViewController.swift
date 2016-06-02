//
//  OneDayWordViewController.swift
//  LovelyDay
//
//  Created by Elise on 16/5/18.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit
public let AutoHeightCellId = "AutoHeightCellId"
class OneDayWordViewController: UIViewController {

    
    //model
    var model:CommentModels?
    
    
    
    
    
    //head部分
    private lazy var headView:DayWordView? = {
        let view = DayWordView.loadDayWordViewFromXib()
        view.frame = CGRect(x: 0, y: 0, width: AppWidth, height: 260)
        return view
    }()
    
    //主要的tableview
    private lazy var mainTableView:UITableView? = {
        let mainTableView = UITableView(frame: CGRectMake(0, 0, AppWidth, AppHeight - NavigationHeight), style: .Plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .None
        mainTableView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        return mainTableView
    }()
    private lazy var shareButton:UIButton = {
        let shareButton:UIButton = UIButton(type: .Custom)
        shareButton.setImage(UIImage(named: "titleshare_1"), forState: .Normal)
        shareButton.setImage(UIImage(named: "titleshare_1"), forState: UIControlState.Highlighted)
        let backButtonWidth: CGFloat = AppWidth > 375.0 ? 50 : 44
        shareButton.frame = CGRectMake(0, 0, backButtonWidth, 44)
        shareButton.addTarget(self, action: "shareButtonClick:", forControlEvents: .TouchUpInside)
        return shareButton
    }()
    private func setRightBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.shareButton)
    }
    //share
    private var shareView = ShareView.loadShareViewFromXib()
    @objc func shareButtonClick(sender:UIButton) {
        self.view.addSubview(shareView)
        shareView.shareVC = self
        shareView.shareButtonClick(CGRect(x: 0, y: AppHeight - 190 - NavigationHeight, width: AppWidth, height: 190))
    }
    //设置主要的tableView
    private func setMainTableView() {
        mainTableView?.tableHeaderView = self.headView!
        self.view.addSubview(mainTableView!)
        self.setRightBarButton()
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainTableView()
        self.view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)

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
extension OneDayWordViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.model?.list?.count ?? 0)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        cell = CommentCell.loadCommentCellWithTableView(tableView)
        (cell as? CommentCell)?.model = self.model?.list?[indexPath.row]
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if self.cellHeightForIndexPath(indexPath, cellContentViewWidth: AppWidth, tableView: tableView) < 80 {
            return 80
        }
        else {
            return self.cellHeightForIndexPath(indexPath, cellContentViewWidth: AppWidth, tableView: tableView)
        }
    }
}
