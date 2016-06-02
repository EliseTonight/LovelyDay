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
        titleLabel?.font = UIFont.systemFontOfSize(16)
        titleLabel?.contentMode = .Center
        imageView?.contentMode = .Left
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRectMake(-5, 0, titleLabel!.frame.width, self.frame.height)
        imageView?.frame = CGRectMake(titleLabel!.frame.width + 3 - 5, 0, self.frame.width - titleLabel!.frame.width - 3, self.frame.height)
    }

}
