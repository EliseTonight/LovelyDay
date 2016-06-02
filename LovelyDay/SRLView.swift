//
//  SRLView.swift
//  LittleDay3.0
//
//  Created by Elise on 16/5/17.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class SRLView: UIView {
    @IBOutlet weak var shopView: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "sViewClick")
            shopView.userInteractionEnabled = true
            shopView.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var lookView: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "lViewClick")
            lookView.userInteractionEnabled = true
            lookView.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var readView: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "rViewClick")
            readView.userInteractionEnabled = true
            readView.addGestureRecognizer(tap)
        }
    }
    var delegate:SRLViewDelegate?
    
    @objc private func sViewClick() {
        if delegate != nil {
            delegate?.SRLViewSViewClick()
        }
    }
    @objc private func lViewClick() {
        if delegate != nil {
            delegate?.SRLViewLViewClick()
        }
    }
    @objc private func rViewClick() {
        if delegate != nil {
            delegate?.SRLViewRViewClick()
        }
    }
    
    
    
    
    
    class func loadSRLViewFromXib() -> SRLView {
        let view = NSBundle.mainBundle().loadNibNamed("SRLView", owner: nil, options: nil).last as! SRLView
        return view
    }
    
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
protocol SRLViewDelegate {
    func SRLViewSViewClick()
    func SRLViewLViewClick()
    func SRLViewRViewClick()
}