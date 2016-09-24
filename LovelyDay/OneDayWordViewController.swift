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
    fileprivate lazy var headView:DayWordView? = {
        let view = DayWordView.loadDayWordViewFromXib()
        view.frame = CGRect(x: 0, y: 0, width: AppWidth, height: 260)
        return view
    }()
    
    //主要的tableview
    fileprivate lazy var mainTableView:UITableView? = {
        let mainTableView = UITableView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight - NavigationHeight), style: .plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        mainTableView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        return mainTableView
    }()
    fileprivate lazy var shareButton:UIButton = {
        let shareButton:UIButton = UIButton(type: .custom)
        shareButton.setImage(UIImage(named: "titleshare_1"), for: UIControlState())
        shareButton.setImage(UIImage(named: "titleshare_1"), for: UIControlState.highlighted)
        let backButtonWidth: CGFloat = AppWidth > 375.0 ? 50 : 44
        shareButton.frame = CGRect(x: 0, y: 0, width: backButtonWidth, height: 44)
        shareButton.addTarget(self, action: "shareButtonClick:", for: .touchUpInside)
        return shareButton
    }()
    fileprivate func setRightBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.shareButton)
    }
    //share
    fileprivate var shareView = ShareView.loadShareViewFromXib()
    @objc func shareButtonClick(_ sender:UIButton) {
        self.view.addSubview(shareView)
        shareView.shareVC = self
        shareView.shareButtonClick(CGRect(x: 0, y: AppHeight - 190 - NavigationHeight, width: AppWidth, height: 190))
    }
    //设置主要的tableView
    fileprivate func setMainTableView() {
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.model?.list?.count ?? 0)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        cell = CommentCell.loadCommentCellWithTableView(tableView)
        (cell as? CommentCell)?.model = self.model?.list?[(indexPath as NSIndexPath).row]
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.cellHeight(for: indexPath, cellContentViewWidth: AppWidth, tableView: tableView) < 80 {
            return 80
        }
        else {
            return self.cellHeight(for: indexPath, cellContentViewWidth: AppWidth, tableView: tableView)
        }
    }
}
