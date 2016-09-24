//
//  RecommedOrSignViewController.swift
//  LovelyDay
//
//  Created by Elise on 16/5/22.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class RecommedOrSignViewController: UIViewController {


    //自带的头部对应的数据
    fileprivate var firstModelData:NSData? {
        didSet {
            self.mainTableView?.reloadData()
        }
    }
    //是否是头部的请求
    fileprivate var isHeadModelRequest:Bool = false
    
    //添加的类型，0为添加图片，1为添加文字，，，，，自带的不存在这个数组里
    fileprivate var model:[Int]? {
        didSet {
            
        }
    }
    //进入的类型,0是推荐小店，1是签到
    fileprivate var type:Int? {
        didSet {
            
        }
    }
    //model每个对应的数据，比如图片NSData，，文字的String
    fileprivate var modelData:[AnyObject?]? {
        didSet {
            self.mainTableView?.reloadData()
        }
    }
    //记录当前选择的CellIndex
    fileprivate var currentIndex:Int? {
        didSet {
            
        }
    }
    
    func setInitData(_ model:[Int]?,type:Int?,modelData:[AnyObject?]?) {
        self.model = model
        self.type = type
        self.modelData = modelData
    }
    
    //选取图片的
    fileprivate lazy var imagePickVC: UIImagePickerController = {
        let pickVC = UIImagePickerController()
        pickVC.delegate = self
        pickVC.allowsEditing = true
        return pickVC
    }()
    fileprivate lazy var imageActionSheet: UIActionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从手机相册选择")
    
    
    
    //底部的View
    fileprivate lazy var tableFootView:SignFootView? = {
        let tableFootView = SignFootView.loadSignFootViewFromXib()
        tableFootView.frame = CGRect(x: 0, y: 0, width: AppWidth, height: 200)
        weak var selfRef = self
        tableFootView.delegate = selfRef
        return tableFootView
    }()
    
    //主要的tableview
    fileprivate lazy var mainTableView:UITableView? = {
        let mainTableView = UITableView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight - NavigationHeight), style: .plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        mainTableView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        return mainTableView
    }()
    //设置主要的tableView
    fileprivate func setMainTableView() {
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
        NotificationCenter.default.addObserver(self, selector: #selector(RecommedOrSignViewController.wordCellDataChange(_:)), name: NSNotification.Name(rawValue: Elise_WordsChange), object: nil)
        // Do any additional setup after loading the view.
        
    }
    
    @objc fileprivate func wordCellDataChange(_ notice:Notification) {
        //文字修改
        if self.model![currentIndex!] == 1 {
            let str = notice.object as? String
            self.modelData![currentIndex!] = str as AnyObject?
        }
    }
    //销毁监视器
    deinit {
        NotificationCenter.default.removeObserver(self)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  (self.model?.count ?? 1)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        if (indexPath as NSIndexPath).row == 0 {
            if type == 0 {
                cell = RecommendCell.loadRecommendCellWithTableView(tableView)
                (cell as? RecommendCell)?.model = self.firstModelData as Data?
            }
            else {
                cell = AddImageViewCell.loadAddImageViewWithTableView(tableView)
                (cell as? AddImageViewCell)?.model = self.firstModelData as Data?            }
        }
        else {
            if model?[(indexPath as NSIndexPath).row] == 0 {
                cell = AddImageViewCell.loadAddImageViewWithTableView(tableView)
                (cell as? AddImageViewCell)?.model = (self.modelData?[(indexPath as NSIndexPath).row] as? Data)
            }
            else {
                cell = AddWordsViewCell.loadAddWordsViewCellWithTableView(tableView)
                (cell as? AddWordsViewCell)?.model = (self.modelData?[(indexPath as NSIndexPath).row] as? String)
            }
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //推荐小店
        if type == 0 {
            if (indexPath as NSIndexPath).row == 0 {
                return 330
            }
            else {
                if model?[(indexPath as NSIndexPath).row] == 0 {
                    return 228
                }
                else {
                    //最小高度80
                    if self.cellHeight(for: indexPath, cellContentViewWidth: AppWidth, tableView: tableView) <= 80 {
                        return 80
                    }
                    else {
                        return self.cellHeight(for: indexPath, cellContentViewWidth: AppWidth, tableView: tableView)
                    }
                }
            }
        }
        //签到
        else {
            if (indexPath as NSIndexPath).row == 0 {
                return 228
            }
            else {
                if model?[(indexPath as NSIndexPath).row] == 0 {
                    return 228
                }
                else {
                    //最小高度80
                    if self.cellHeight(for: indexPath, cellContentViewWidth: AppWidth, tableView: tableView) <= 80 {
                        return 80
                    }
                    else {
                        return self.cellHeight(for: indexPath, cellContentViewWidth: AppWidth, tableView: tableView)
                    }
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (indexPath as NSIndexPath).row == 0 {
            return false
        }
        else {
            return true
        }
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deletAct = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "删除", handler: { (action, index) -> Void in
            self.model?.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            self.modelData?.remove(at: (indexPath as NSIndexPath).row)
        })
        return [deletAct]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).row == 0 {
            if type == 0 {
                isHeadModelRequest = true;
                self.currentIndex = 0
                self.imageActionSheet.show(in: self.view)
            }
            else {
                self.currentIndex = 0
                self.imageActionSheet.show(in: self.view)
                isHeadModelRequest = true;
            }
            
        }
        else {
            if model?[(indexPath as NSIndexPath).row] == 1 {
                let vc = WriteViewController()
                let naviVC = UINavigationController(rootViewController: vc)
                self.currentIndex = (indexPath as NSIndexPath).row
                vc.model = self.modelData?[(indexPath as NSIndexPath).row] as? String
                self.navigationController?.present(naviVC, animated: true, completion: nil)
            }
            else {
                self.currentIndex = (indexPath as NSIndexPath).row
                self.imageActionSheet.show(in: self.view)
                
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
    fileprivate func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickVC.sourceType = .camera
            self.present(imagePickVC, animated: true, completion: nil)
        } else {
            SVProgressHUD.showError(withStatus: "无法打开摄像头", maskType: SVProgressHUDMaskType.black)
        }
    }
    fileprivate func openAlbum() {
        imagePickVC.sourceType = .photoLibrary
        self.present(imagePickVC, animated: true, completion: nil)
    }
    //实现delegate，剪切图片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let typeStr = info[UIImagePickerControllerMediaType] as? String {
            if typeStr == "public.image" {
                if let rowImage = info[UIImagePickerControllerEditedImage] as? UIImage {
                    var data:Data?
                    let smallImage = rowImage.scaleToFitNeedSize(CGSize(width: AppWidth, height: 180))
                    //图片，与质量
                    data = UIImageJPEGRepresentation(smallImage, 1.0)
                    if data != nil {
                        if isHeadModelRequest {
                            self.firstModelData = data as NSData?
                            isHeadModelRequest = false;
                        }
                        else {
                            self.modelData![currentIndex!] = data as AnyObject?
                        }
                        
                    } else {
                        SVProgressHUD.showError(withStatus: "设置失败", maskType: SVProgressHUDMaskType.black)
                    }

                }
            }
        }
        imagePickVC.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickVC.dismiss(animated: true, completion: nil)
    }
}

extension RecommedOrSignViewController:UIActionSheetDelegate {
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
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










