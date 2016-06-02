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
            likeButton.setImage(UIImage(named: "plike_3"), forState: UIControlState.Selected)
        }
    }
    @IBOutlet weak var likeLabel: UILabel! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "likeLabelClick")
            likeLabel.userInteractionEnabled = true
            likeLabel.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var consultButton: UIButton!
    @IBOutlet weak var consultLabel: UILabel!
    
    @IBAction func likeButtonClick(sender: UIButton) {
        sender.selected = !sender.selected
    }
    @objc private func likeLabelClick() {
        self.likeButton.selected = !self.likeButton.selected
    }
    
    
    @IBAction func consultButtonClick(sender: UIButton) {
        
    }
    
    
    class func loadFunDetailBottomViewFromXib() -> FunDetailBottomView {
        let view = NSBundle.mainBundle().loadNibNamed("FunDetailBottomView", owner: nil, options: nil).last as? FunDetailBottomView
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
