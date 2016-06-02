//
//  RecordView.swift
//  LovelyDay
//
//  Created by Elise on 16/5/20.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class RecordView: UIView {
    
    @IBOutlet weak var correctView: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "correctViewClick")
            correctView.addGestureRecognizer(tap)
            correctView.userInteractionEnabled = true
        }
    }
    @IBOutlet weak var signButton: UIButton!
    
    
    
    @IBAction func signButtonClick(sender: UIButton) {
        delegate?.recordViewSignButton()
    }
    
    
    @objc private func correctViewClick() {
        
    }
    
    var delegate:RecordViewDelegate?
    
    
    
    
    class func loadRecordViewFromXib() -> RecordView {
        let view = NSBundle.mainBundle().loadNibNamed("RecordView", owner: nil, options: nil).last as? RecordView
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
protocol RecordViewDelegate {
    func recordViewSignButton()
}