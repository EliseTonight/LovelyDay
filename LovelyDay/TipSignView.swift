//
//  TipSignView.swift
//  LovelyDay
//
//  Created by Elise on 16/5/20.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class TipSignView: UIView {
    
    @IBOutlet weak var tipImageView: UIImageView!
    @IBOutlet weak var tipNameLabel: UILabel!

    
    var model:TipModel? {
        didSet {
            self.tipNameLabel.text = model?.name
            self.tipImageView.sd_setImageWithURL(NSURL(string: (model?.img)!))
        }
    }
    
    
    
    
    
    class func loadTipSignViewFromXib(tipModel model:TipModel) -> TipSignView {
        let view = NSBundle.mainBundle().loadNibNamed("TipSignView", owner: nil, options: nil).last as? TipSignView
        view?.model = model
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
