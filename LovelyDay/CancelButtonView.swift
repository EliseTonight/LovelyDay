//
//  CancelButtonView.swift
//  LovelyDay
//
//  Created by Elise on 16/6/1.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class CancelButtonView: UIView {
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func cancelButtonClick(_ sender: UIButton) {
        delegate?.CancelButtonViewClick()
    }
    
    var delegate:CancelButtonViewDelegate?
    
    
    
    
    
    
    
    

    class func loadCancelButtonViewFromXib() -> CancelButtonView {
        let view = Bundle.main.loadNibNamed("CancelButtonView", owner: nil, options: nil)?.last as? CancelButtonView
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

protocol CancelButtonViewDelegate {
    func CancelButtonViewClick()
}
