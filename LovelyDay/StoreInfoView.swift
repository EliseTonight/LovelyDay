//
//  StoreInfoView.swift
//  LovelyDay
//
//  Created by Elise on 16/5/20.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class StoreInfoView: UIView {
    
    @IBOutlet weak var rightImageView: UIImageView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "rightImageClick")
            rightImageView.addGestureRecognizer(tap)
            rightImageView.userInteractionEnabled = true
        }
    }
    @IBOutlet weak var titleInfoLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @objc private func rightImageClick() {
        switch type! {
        case 3:
            self.callActionSheet?.showInView(self)
        case 4:
            //发布进入定位通知
            NSNotificationCenter.defaultCenter().postNotificationName(Elise_ShopLocationNotification, object: nil)
        default:
            break
        }
    }
    
    
    
    
    var type:Int? {
        didSet {
            switch type! {
            case 1:
                typeLabel.text = "人均消费"
                self.rightImageView.hidden = true
                self.rightImageView.userInteractionEnabled = false
            case 2:
                typeLabel.text = "营业时间"
                self.rightImageView.hidden = true
                self.rightImageView.userInteractionEnabled = false
            case 3:
                typeLabel.text = "店铺电话"
                self.rightImageView.image = UIImage(named: "phone_1")
            case 4:
                typeLabel.text = "店铺地址"
                self.rightImageView.image = UIImage(named: "navigation_1")
            default:
                break
            }
        }
    }
    
    var model:String? {
        didSet {
            if self.type == 1 {
                if model == "0" {
                    self.titleInfoLabel.text = "免费"
                }
            }
            else {
                self.titleInfoLabel.text = model
            }
        }
    }
    //电话的actionSheet
    private lazy var callActionSheet:UIActionSheet? = {
        let call = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: self.model)
        return call
    }()
    
    class func loadStoreInfoViewFromXib(title:String,type:Int) -> StoreInfoView {
        let view = NSBundle.mainBundle().loadNibNamed("StoreInfoView", owner: nil, options: nil).last as? StoreInfoView
        view?.type = type
        view?.model = title
        return view!
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
extension StoreInfoView:UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            let numURL = "tel://" + self.model!
            UIApplication.sharedApplication().openURL(NSURL(string: numURL)!)
        }
    }
}
