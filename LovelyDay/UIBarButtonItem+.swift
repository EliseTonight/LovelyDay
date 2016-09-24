//
//  UIBarButtonItem+.swift
//  LovelyDay
//
//  Created by Elise on 16/6/1.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /// 导航条纯文字按钮
    convenience init(title: String, titleClocr: UIColor, targer: AnyObject ,action: Selector) {
        
        let button = UIButton(type: .custom)
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(titleClocr, for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 44)
        button.titleLabel?.textAlignment = NSTextAlignment.right
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5)
        button.addTarget(targer, action: action, for: .touchUpInside)
        
        self.init(customView: button)
    }
}
