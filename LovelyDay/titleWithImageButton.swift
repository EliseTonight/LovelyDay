//
//  titleWithImageButton.swift
//  LittleDay
//
//  Created by Elise on 16/3/15.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class titleWithImageButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        titleLabel?.contentMode = .center
        imageView?.contentMode = .left
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRect(x: -5, y: 0, width: titleLabel!.frame.width, height: self.frame.height)
        imageView?.frame = CGRect(x: titleLabel!.frame.width + 3 - 5, y: 0, width: self.frame.width - titleLabel!.frame.width - 3, height: self.frame.height)
    }

}
