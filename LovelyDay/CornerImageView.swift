//
//  CornerImageView.swift
//  LittleDay3.0
//
//  Created by Elise on 16/5/18.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit
@IBDesignable

class CornerImageView: UIImageView {
    
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidrh:CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidrh
        }
    }
    @IBInspectable var borderColor:UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.CGColor
        }
    }

    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
