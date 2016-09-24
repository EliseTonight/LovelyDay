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
    
    func setButton(_ button:UIButton,frame:CGRect,image:String,highLightImage:String,selectedImage:String?,action:Selector) {
        button.frame = frame
        button.setImage(UIImage(named: image), for: UIControlState())
        button.setImage(UIImage(named: highLightImage), for: .highlighted)
        if selectedImage != nil {
            button.setImage(UIImage(named: selectedImage!), for: .selected)
        }
        button.addTarget(self, action: action, for: .touchUpInside)
        self.view.addSubview(button)
    }
    
}
