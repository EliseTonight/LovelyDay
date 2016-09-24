//
//  SetInfoView.swift
//  LovelyDay
//
//  Created by Elise on 16/6/1.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class SetInfoView: UIView {
    
    @IBOutlet weak var setNameLabel: UILabel!
    
    @IBOutlet weak var setHeadView: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "setImageViewClick")
            setHeadView.isUserInteractionEnabled = true
            setHeadView.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var setHeadImage: CornerImageView!
    @IBOutlet weak var setNameView: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "setNameViewClick")
            setNameView.isUserInteractionEnabled = true
            setNameView.addGestureRecognizer(tap)
        }
    }

    @IBOutlet weak var setSignLabel: UILabel!
    @IBOutlet weak var aboutMyselfView: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "aboutMyselfViewClick")
            aboutMyselfView.isUserInteractionEnabled = true
            aboutMyselfView.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var setSignView: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "setSignViewClick")
            setSignView.isUserInteractionEnabled = true
            setSignView.addGestureRecognizer(tap)
        }
    }

    
    @objc fileprivate func setImageViewClick() {
        delegate?.setInfoView(imageViewClick: self.setHeadImage)
    }
    @objc fileprivate func setNameViewClick() {
        delegate?.setInfoView(nameViewClick: setNameLabel)
    }
    @objc fileprivate func aboutMyselfViewClick() {
        delegate?.setInfoViewShowMyself()
    }
    @objc fileprivate func setSignViewClick() {
        delegate?.setInfoView(signViewClick: setSignLabel)
    }
    
    
    
    var model:UserModel? {
        didSet {
            self.setHeadImage.sd_setImage(with: URL(string: (model?.head_photo)!), placeholderImage: UIImage(named: "logo_s"))
            self.setSignLabel.text = model?.sign
            self.setNameLabel.text = model?.name
        }
    }
    
    
    
    
    
    var delegate:SetInfoViewDelegate?
    
    
    
    
    
    
    
    
    
    
    
    class func loadSetInfoView() -> SetInfoView {
        let view = Bundle.main.loadNibNamed("SetInfoView", owner: nil, options: nil)?.last as? SetInfoView
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
protocol SetInfoViewDelegate {
    func setInfoView(imageViewClick imageView:UIImageView)
    func setInfoView(nameViewClick nameLabel:UILabel)
    func setInfoView(signViewClick signLabel:UILabel)
    func setInfoViewShowMyself()
}
