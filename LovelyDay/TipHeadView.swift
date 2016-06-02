//
//  TipHeadView.swift
//  LovelyDay
//
//  Created by Elise on 16/5/21.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class TipHeadView: UIView {

    
    
    
    
    
    class func loadTipHeadViewFromXib() -> TipHeadView {
        let view = NSBundle.mainBundle().loadNibNamed("TipHeadView", owner: nil, options: nil).last as? TipHeadView
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
