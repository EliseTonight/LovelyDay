//
//  MeHeadView.swift
//  LovelyDay
//
//  Created by Elise on 16/5/31.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class MeHeadView: UIView {
    
    
    @IBOutlet weak var meBackImageView: UIImageView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "setBackgroundClick")
            meBackImageView.isUserInteractionEnabled = true
            meBackImageView.addGestureRecognizer(tap)
        }
        
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: CornerImageView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "setUserInfo")
            iconImageView.isUserInteractionEnabled = true
            iconImageView.addGestureRecognizer(tap)
        }
    }
    
    
    @objc fileprivate func setBackgroundClick() {
        delegate?.MeHeadView(clickBackgroundImage: self.meBackImageView)
    }
    @objc fileprivate func setUserInfo() {
        delegate?.MeHeadView(clickIconImage: self.iconImageView)
    }
    var delegate:MeHeadViewDelegate?
    
    var model:UserModel? {
        didSet {
            self.nameLabel.text = model?.name
            self.iconImageView.sd_setImage(with: URL(string: (model?.head_photo)!), placeholderImage: UIImage(named: "logo_s"))
            self.meBackImageView.sd_setImage(with: URL(string: (model?.background_url)!), placeholderImage: UIImage(named: "defaultbackground"))
        }
    }
    
    
    
    
    
    
    
    
    
    class func loadMeHeadViewFromXib() -> MeHeadView {
        let view = Bundle.main.loadNibNamed("MeHeadView", owner: nil, options: nil)?.last as? MeHeadView
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

protocol MeHeadViewDelegate {
    func MeHeadView(clickBackgroundImage image:UIImageView)
    func MeHeadView(clickIconImage image:UIImageView)
}

