//
//  FunDetailBottomView.swift
//  LovelyDay
//
//  Created by Elise on 16/5/28.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class FunDetailBottomView: UIView {
    
    @IBOutlet weak var likeButton: UIButton! {
        didSet {
            likeButton.setImage(UIImage(named: "plike_3"), for: UIControlState.selected)
        }
    }
    @IBOutlet weak var likeLabel: UILabel! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "likeLabelClick")
            likeLabel.isUserInteractionEnabled = true
            likeLabel.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var consultButton: UIButton!
    @IBOutlet weak var consultLabel: UILabel!
    
    @IBAction func likeButtonClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @objc fileprivate func likeLabelClick() {
        self.likeButton.isSelected = !self.likeButton.isSelected
    }
    
    
    @IBAction func consultButtonClick(_ sender: UIButton) {
        
    }
    
    
    class func loadFunDetailBottomViewFromXib() -> FunDetailBottomView {
        let view = Bundle.main.loadNibNamed("FunDetailBottomView", owner: nil, options: nil)?.last as? FunDetailBottomView
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
