//
//  SignFootView.swift
//  LovelyDay
//
//  Created by Elise on 16/5/22.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class SignFootView: UIView {
    
    @IBOutlet weak var addTitleButton: UIButton!
    @IBOutlet weak var addImageButton: UIButton!
    @IBAction func addTitleButtonClick(_ sender: UIButton) {
        delegate?.signFootViewAddTitle()
    }
    @IBAction func addImageButtonClick(_ sender: UIButton) {
        delegate?.signFootViewAddImage()
    }
    
    
    var delegate:SignFootViewDelegate?
    
    
    
    
    
    
    
    
    class func loadSignFootViewFromXib() -> SignFootView {
        let view = Bundle.main.loadNibNamed("SignFootView", owner: nil, options: nil)?.last as? SignFootView
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

protocol SignFootViewDelegate {
    func signFootViewAddTitle()
    func signFootViewAddImage()
}
