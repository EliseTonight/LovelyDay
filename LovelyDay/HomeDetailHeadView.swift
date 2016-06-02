//
//  HomeDetailHeadView.swift
//  LovelyDay
//
//  Created by Elise on 16/5/20.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class HomeDetailHeadView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    
    var model:HomeModel? {
        didSet {
            self.titleLabel.text = model?.title
            self.nameLabel.text = "− " + (model?.name)! + " −"
            self.typeLabel.text = model?.space?.name
        }
    }
    
    
    
    class func loadHomeDetailHeadViewFromXib() -> HomeDetailHeadView {
        let view = NSBundle.mainBundle().loadNibNamed("HomeDetailHeadView", owner: nil, options: nil).last as! HomeDetailHeadView
        return view
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
