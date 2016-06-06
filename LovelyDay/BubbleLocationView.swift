//
//  BubbleLocationView.swift
//  LovelyDay
//
//  Created by Elise on 16/6/4.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class BubbleLocationView: UIView {

    //背景
    private lazy var backImage:UIImageView = UIImageView()
    //文字
    private lazy var adressLabel:UILabel = UILabel()
    //图片
    private lazy var locationButton = UIButton()
    
    
    
    var model:HomeModel? {
        didSet {
            self.adressLabel.text = model?.address
        }
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.adressLabel.font = UIFont.systemFontOfSize(17)
        adressLabel.textAlignment = .Center
        self.locationButton.setBackgroundImage(UIImage(named: "daohang"), forState: UIControlState.Normal)
        self.backImage.image = UIImage(named: "daohangbg")
        self.addSubview(backImage)
        self.backImage.addSubview(adressLabel)
        self.backImage.addSubview(locationButton)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backImage.frame = self.bounds
        adressLabel.frame = CGRect(x: 8, y: 8, width: self.backImage.width - 56, height: self.backImage.height / 2)
        self.locationButton.frame = CGRect(x: self.backImage.width - 48, y: (self.backImage.height / 6) + 4, width: 40, height: self.backImage.height / 3)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
