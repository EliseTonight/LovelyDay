//
//  TopPartOneView.swift
//  LovelyDay
//
//  Created by Elise on 16/5/29.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class TopPartOneView: UIView {
    
    @IBOutlet weak var mainView: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "mainViewClick")
            mainView.userInteractionEnabled = true
            mainView.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconNameLabel: UILabel!
    private var id:Int?
    
    @objc private func mainViewClick() {
        delegate?.topPartOneView(selectedId: self.id, didSeletedName: self.iconNameLabel.text)
    }
    var delegate:TopPartOneViewDelegate?
    
    var model:DescoverTopIconModel? {
        didSet {
            self.iconImageView.sd_setImageWithURL(NSURL(string: (model?.icon)!))
            self.iconNameLabel.text = model?.name
            self.id = model?.id
        }
    }
    ///设置更多的view
    func modelSetAsMore(image:String,id:Int,title:String) {
        self.iconImageView.image = UIImage(named: image)
        self.iconNameLabel.text = title
        self.id = id
    }
    
    
    
    ///传入index与Y的值，按序号设置frame
    class func loadTopPartOneViewFromXib(index:CGFloat,ySet:CGFloat) -> TopPartOneView {
        let view = NSBundle.mainBundle().loadNibNamed("TopPartOneView", owner: nil, options: nil).last as? TopPartOneView
        view?.frame = CGRectMake(index * (AppWidth / 4), ySet, (AppWidth / 4), 100)
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
protocol TopPartOneViewDelegate {
    func topPartOneView(selectedId id:Int?,didSeletedName name:String?)
}

