//
//  ThemeViewController.swift
//  LovelyDay
//
//  Created by Elise on 16/5/29.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit
///本view更具载入的id来输入数据，，这边全部通用一个了
class ThemeViewController: UIViewController {

    var model:DescoverModel? {
        didSet {
            
        }
    }
    ///themeModel
    var themeModel:HomeModels? {
        didSet {
            
        }
    }
    
    
    //设置右边的Button
    private lazy var likeButton:UIButton = {
        let likeButton:UIButton = UIButton(type: .Custom)
        likeButton.setImage(UIImage(named: "titlelike_1"), forState: .Normal)
        likeButton.setImage(UIImage(named: "listlike_2"), forState: UIControlState.Selected)
        let backButtonWidth: CGFloat = AppWidth > 375.0 ? 50 : 44
        likeButton.frame = CGRectMake(0, 0, backButtonWidth, 44)
        likeButton.addTarget(self, action: "likeButtonClick:", forControlEvents: .TouchUpInside)
        return likeButton
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
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: self.shareButton),UIBarButtonItem(customView: likeButton)]
    }
    @objc func likeButtonClick(sender:UIButton) {
        //likeButton的动画，但是x轴会变化，，怎么办？。。。
        //        let scale:CGFloat = 1.2
        //        UIView.animateWithDuration(0.1, animations: { () -> Void in
        //            sender.transform = CGAffineTransformMakeScale(1.1, 1.1)
        //            }) { (success) -> Void in
        //                sender.selected = !sender.selected
        //                UIView.animateWithDuration(0.1, animations: { () -> Void in
        //                    sender.transform = CGAffineTransformMakeScale(1.0, 1.0)
        //                })
        //        }
        sender.selected = !sender.selected
    }
    //share
    private var shareView = ShareView.loadShareViewFromXib()
    @objc func shareButtonClick(sender:UIButton) {
        self.view.addSubview(shareView)
        shareView.shareVC = self
        shareView.shareButtonClick(CGRect(x: 0, y: AppHeight - 190 - NavigationHeight, width: AppWidth, height: 190))
    }
    
    ///头部的view
    private lazy var headView:UIView? = {
        let view = UIView()
        return view
    }()
    //part1图片与文字
    private lazy var headImage:UIImageView? = {
        let headImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: 180))
        headImageView.sd_setImageWithURL(NSURL(string: self.model!.img!))
        return headImageView
    }()
    private lazy var headLabel:UILabel? = {
        let label = UILabel(frame: CGRect(x: 0, y: 70, width: AppWidth, height: 40))
        label.textAlignment = .Center
        label.text = self.model?.title
        label.textColor = UIColor.whiteColor()
        return label
    }()
    //part2自适应大小的Label
    private lazy var autoHeadLabel:UILabel = UILabel()
    private lazy var autoHeadLabelBack:UIView = UIView()
    
    private func setHeadView() {
        self.view.addSubview(headView!)
        self.headView?.addSubview(headImage!)
        self.headView?.addSubview(headLabel!)
        self.headView?.addSubview(autoHeadLabelBack)
        self.headView?.addSubview(autoHeadLabel)
        
        self.autoHeadLabel.text = model?.content!
        self.autoHeadLabel.sd_layout()
        .yIs(180)
        .topSpaceToView(headImage,10)
        .leftSpaceToView(headView,20)
        .rightSpaceToView(headView,20)
        .autoHeightRatio(0)
        self.autoHeadLabel.font = UIFont.systemFontOfSize(15)
        self.headView?.sd_layout()
        .yIs(0)
        .widthIs(AppWidth)
        self.autoHeadLabelBack.sd_layout()
        .yIs(180)
        .leftSpaceToView(headView,0)
        .rightSpaceToView(headView,0)
        .heightRatioToView(autoHeadLabel,1.1)
        ///完成布局，得到headView的frame,用以设置tableHeadView
        self.headView?.layoutIfNeeded()
        let height = self.autoHeadLabelBack.frame.height + 180
        self.headView?.frame = CGRect(x: 0, y: 0, width: AppWidth, height: height)
        self.autoHeadLabelBack.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
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
        self.mainTableView?.tableHeaderView = self.headView
        self.view.addSubview(mainTableView!)
        self.mainTableView?.reloadData()
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        setRightBarButton()
        
        setHeadView()
        
        setMainTableView()
        
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
extension ThemeViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.themeModel?.list?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell?
        cell = ThemeCell.loadThemeCellWithTableView(tableView)
        (cell as? ThemeCell)?.model = self.themeModel?.list![indexPath.row]
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.cellHeightForIndexPath(indexPath, cellContentViewWidth: AppWidth, tableView: tableView)
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = HomeDetailViewController()
        vc.model = self.themeModel?.list![indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
