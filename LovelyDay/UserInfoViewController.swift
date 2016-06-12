//
//  UserInfoViewController.swift
//  LovelyDay
//
//  Created by Elise on 16/6/1.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class UserInfoViewController: MainViewController {
    
    
    var model:UserModel? {
        didSet {
            self.setInfoView?.model = model
        }
    }
    
    
    
    
    
    //view
    private lazy var mainScrollView:UIScrollView? = {
        let mainScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight - NavigationHeight))
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        mainScrollView.contentSize = CGSize(width: AppWidth, height: 675 + 66)
        return mainScrollView
    }()
    private lazy var setInfoView:SetInfoView? = {
        let setInfoView = SetInfoView.loadSetInfoView()
        setInfoView.frame = CGRect(x: 0, y: 0, width: AppWidth, height: 675)
        let selfRef = self
        setInfoView.delegate = selfRef
        return setInfoView
    }()
    private lazy var cancelButtonView:CancelButtonView? = {
        let cancelButtonView = CancelButtonView.loadCancelButtonViewFromXib()
        cancelButtonView.frame = CGRect(x: 0, y: 675, width: AppWidth, height: 66)
        let selfRef = self
        cancelButtonView.delegate = selfRef
        return cancelButtonView
    }()
    private func setMainScrollView() {
        self.view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.title = "个人中心"
        self.view.addSubview(mainScrollView!)
        self.mainScrollView?.addSubview(setInfoView!)
        self.mainScrollView?.addSubview(cancelButtonView!)
    }
    
    
    
    //选取图片的
    private lazy var imagePickVC: UIImagePickerController = {
        let pickVC = UIImagePickerController()
        pickVC.delegate = self
        pickVC.allowsEditing = true
        return pickVC
    }()
    private lazy var imageActionSheet: UIActionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从手机相册选择")
    
    
    
    
    
    
    lazy var backButton:UIButton = {
        let backButton:UIButton = UIButton(type: .Custom)
        backButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        backButton.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        backButton.titleLabel?.font = UIFont.systemFontOfSize(17)
        backButton.setImage(UIImage(named: "back_1"), forState: .Normal)
        backButton.setImage(UIImage(named: "back_2"), forState: .Highlighted)
        backButton.contentHorizontalAlignment = .Left
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0)
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        let backButtonWidth: CGFloat = AppWidth > 375.0 ? 50 : 44
        backButton.frame = CGRectMake(0, 0, backButtonWidth, 40)
        backButton.addTarget(self, action: "turnBack:", forControlEvents: .TouchUpInside)
        return backButton
    }()
    @objc private func turnBack(sender:UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setMainScrollView()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.backButton)
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

extension UserInfoViewController:SetInfoViewDelegate {
    func setInfoView(signViewClick nameLabel: UILabel) {
        let vc = ChangeInfoViewController()
        vc.model = self.model?.sign
        vc.titleType = "签名"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func setInfoViewShowMyself() {
        
    }
    func setInfoView(imageViewClick imageView: UIImageView) {
        self.imageActionSheet.showInView(self.view)
    }
    func setInfoView(nameViewClick nameLabel: UILabel) {
        let vc = ChangeInfoViewController()
        vc.model = self.model?.name
        vc.titleType = "用户名"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension UserInfoViewController:CancelButtonViewDelegate {
    func CancelButtonViewClick() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

extension UserInfoViewController:UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
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
                        SVProgressHUD.showErrorWithStatus("设置成功，但不修改了－ －", maskType: SVProgressHUDMaskType.Black)
//                        self.modelData![currentIndex!] = data
                        
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

extension UserInfoViewController:UIActionSheetDelegate {
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
