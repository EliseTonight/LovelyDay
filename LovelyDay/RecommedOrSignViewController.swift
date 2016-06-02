//
//  RecommedOrSignViewController.swift
//  LovelyDay
//
//  Created by Elise on 16/5/22.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class RecommedOrSignViewController: UIViewController {

    
    //添加的类型，0为添加图片，1为添加文字，，，，，自带的不存在这个数组里
    private var model:[Int]? {
        didSet {
            
        }
    }
    //进入的类型,0是推荐小店，1是签到
    private var type:Int? {
        didSet {
            
        }
    }
    //model每个对应的数据，比如图片NSData，，文字的String
    private var modelData:[AnyObject?]? {
        didSet {
            self.mainTableView?.reloadData()
        }
    }
    //记录当前选择的CellIndex
    private var currentIndex:Int? {
        didSet {
            
        }
    }
    
    func setInitData(model:[Int]?,type:Int?,modelData:[AnyObject?]?) {
        self.model = model
        self.type = type
        self.modelData = modelData
    }
    
    //选取图片的
    private lazy var imagePickVC: UIImagePickerController = {
        let pickVC = UIImagePickerController()
        pickVC.delegate = self
        pickVC.allowsEditing = true
        return pickVC
    }()
    private lazy var imageActionSheet: UIActionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从手机相册选择")
    
    
    
    //底部的View
    private lazy var tableFootView:SignFootView? = {
        let tableFootView = SignFootView.loadSignFootViewFromXib()
        tableFootView.frame = CGRect(x: 0, y: 0, width: AppWidth, height: 200)
        weak var selfRef = self
        tableFootView.delegate = selfRef
        return tableFootView
    }()
    
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
        mainTableView?.tableFooterView = self.tableFootView!
        self.view.addSubview(mainTableView!)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if type == 0 {
            self.navigationController?.title = "推荐小店"
        }
        else {
            self.navigationController?.title = "签到"
        }
        
        setMainTableView()
        
        //添加修改文字的监视器
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "wordCellDataChange:", name: Elise_WordsChange, object: nil)
        // Do any additional setup after loading the view.
        
    }
    
    @objc private func wordCellDataChange(notice:NSNotification) {
        //文字修改
        if self.model![currentIndex!] == 1 {
            let str = notice.object as? String
            self.modelData![currentIndex!] = str
        }
    }
    //销毁监视器
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
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

extension RecommedOrSignViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  (self.model?.count ?? 1)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        if indexPath.row == 0 {
            if type == 0 {
                cell = RecommendCell.loadRecommendCellWithTableView(tableView)
            }
            else {
                cell = AddImageViewCell.loadAddImageViewWithTableView(tableView)
            }
        }
        else {
            if model?[indexPath.row] == 0 {
                cell = AddImageViewCell.loadAddImageViewWithTableView(tableView)
                (cell as? AddImageViewCell)?.model = (self.modelData?[indexPath.row] as? NSData)
            }
            else {
                cell = AddWordsViewCell.loadAddWordsViewCellWithTableView(tableView)
                (cell as? AddWordsViewCell)?.model = (self.modelData?[indexPath.row] as? String)
            }
        }
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //推荐小店
        if type == 0 {
            if indexPath.row == 0 {
                return 330
            }
            else {
                if model?[indexPath.row] == 0 {
                    return 228
                }
                else {
                    //最小高度80
                    if self.cellHeightForIndexPath(indexPath, cellContentViewWidth: AppWidth, tableView: tableView) <= 80 {
                        return 80
                    }
                    else {
                        return self.cellHeightForIndexPath(indexPath, cellContentViewWidth: AppWidth, tableView: tableView)
                    }
                }
            }
        }
        //签到
        else {
            if indexPath.row == 0 {
                return 228
            }
            else {
                if model?[indexPath.row] == 0 {
                    return 228
                }
                else {
                    //最小高度80
                    if self.cellHeightForIndexPath(indexPath, cellContentViewWidth: AppWidth, tableView: tableView) <= 80 {
                        return 80
                    }
                    else {
                        return self.cellHeightForIndexPath(indexPath, cellContentViewWidth: AppWidth, tableView: tableView)
                    }
                }
            }
        }
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        }
        else {
            return true
        }
    }
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deletAct = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "删除") { (action, index) -> Void in
            self.model?.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.modelData?.removeAtIndex(indexPath.row)
        }
        return [deletAct]
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            
        }
        else {
            if model?[indexPath.row] == 1 {
                let vc = WriteViewController()
                let naviVC = UINavigationController(rootViewController: vc)
                self.currentIndex = indexPath.row
                vc.model = self.modelData?[indexPath.row] as? String
                self.navigationController?.presentViewController(naviVC, animated: true, completion: nil)
            }
            else {
                self.currentIndex = indexPath.row
                self.imageActionSheet.showInView(self.view)
                
            }
        }
    }
}

extension RecommedOrSignViewController:SignFootViewDelegate {
    func signFootViewAddImage() {
        self.model?.append(0)
        self.modelData?.append(nil)
        if mainTableView?.contentSize.height > mainTableView?.frame.height {
            let offy = (mainTableView?.contentSize.height)! - (mainTableView?.frame.height)!
            self.mainTableView?.setContentOffset(CGPoint(x: 0, y: offy), animated: true)
        }
    }
    func signFootViewAddTitle() {
        self.model?.append(1)
        self.modelData?.append(nil)
        self.mainTableView?.setContentOffset(CGPoint(x: 0, y: (mainTableView?.contentOffset.y)! + 80), animated: true)
    }
}

extension RecommedOrSignViewController:UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
    /// 打开照相功能
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePickVC.sourceType = .Camera
            self.presentViewController(imagePickVC, animated: true, completion: nil)
        } else {
            SVProgressHUD.showErrorWithStatus("无法打开摄像头", maskType: SVProgressHUDMaskType.Black)
        }
    }
    private func openAlbum() {
        imagePickVC.sourceType = .PhotoLibrary
        self.presentViewController(imagePickVC, animated: true, completion: nil)
    }
    //实现delegate，剪切图片
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let typeStr = info[UIImagePickerControllerMediaType] as? String {
            if typeStr == "public.image" {
                if let rowImage = info[UIImagePickerControllerEditedImage] as? UIImage {
                    var data:NSData?
                    let smallImage = rowImage.scaleToFitNeedSize(CGSize(width: AppWidth, height: 180))
                    //图片，与质量
                    data = UIImageJPEGRepresentation(smallImage, 1.0)
                    if data != nil {
                        self.modelData![currentIndex!] = data
                        
                    } else {
                        SVProgressHUD.showErrorWithStatus("设置失败", maskType: SVProgressHUDMaskType.Black)
                    }

                }
            }
        }
        imagePickVC.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        imagePickVC.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension RecommedOrSignViewController:UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 1:
            self.openCamera()
        case 2:
            self.openAlbum()
        default:
            break
        }
    }
}










