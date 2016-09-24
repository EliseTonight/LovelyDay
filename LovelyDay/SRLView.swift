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
            shopView.isUserInteractionEnabled = true
            shopView.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var lookView: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "lViewClick")
            lookView.isUserInteractionEnabled = true
            lookView.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var readView: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "rViewClick")
            readView.isUserInteractionEnabled = true
            readView.addGestureRecognizer(tap)
        }
    }
    var delegate:SRLViewDelegate?
    
    @objc fileprivate func sViewClick() {
        if delegate != nil {
            delegate?.SRLViewSViewClick()
        }
    }
    @objc fileprivate func lViewClick() {
        if delegate != nil {
            delegate?.SRLViewLViewClick()
        }
    }
    @objc fileprivate func rViewClick() {
        if delegate != nil {
            delegate?.SRLViewRViewClick()
        }
    }
    
    
    
    
    
    class func loadSRLViewFromXib() -> SRLView {
        let view = Bundle.main.loadNibNamed("SRLView", owner: nil, options: nil)?.last as! SRLView
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
