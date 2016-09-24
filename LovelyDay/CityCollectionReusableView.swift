//
//  CityCollectionReusableView.swift
//  LittleDay
//
//  Created by Elise on 16/3/14.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class CityCollectionReusableView: UICollectionReusableView {
    var headLabel:UILabel = UILabel()
    var headTitle:String? {
        didSet {
            headLabel.text = headTitle
            headLabel.font = UIFont.systemFont(ofSize: 18)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.headLabel.frame = self.bounds
    }
    
    
    
    
    
    fileprivate func setUI() {
        headLabel.textAlignment = .center
        headLabel.textColor = UIColor.black
        headLabel.font = UIFont.systemFont(ofSize: 22)
        self.addSubview(headLabel)
        
    }
    
}
class CityCollectionFootResusableView:UICollectionReusableView {
    
    fileprivate var footLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        footLabel = UILabel()
        footLabel?.text = "推荐身边最美的小店"
        footLabel?.textAlignment = .center
        footLabel?.textColor = UIColor.darkGray
        footLabel?.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(footLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    
}



