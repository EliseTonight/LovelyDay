//
//  UIViewController+.swift
//  LovelyDay
//
//  Created by Elise on 16/5/20.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation

import Foundation
extension UIViewController {
    
    func setButton(button:UIButton,frame:CGRect,image:String,highLightImage:String,selectedImage:String?,action:Selector) {
        button.frame = frame
        button.setImage(UIImage(named: image), forState: .Normal)
        button.setImage(UIImage(named: highLightImage), forState: .Highlighted)
        if selectedImage != nil {
            button.setImage(UIImage(named: selectedImage!), forState: .Selected)
        }
        button.addTarget(self, action: action, forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
    }
    
}