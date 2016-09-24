//
//  DayWordView.swift
//  LovelyDay
//
//  Created by Elise on 16/5/18.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class DayWordView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthAndYearLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton! {
        didSet {
            likeButton.setImage(UIImage(named: "signlike_3"), for: UIControlState.selected)
            likeButton.addTarget(self, action: "likeButtonClick:", for: UIControlEvents.touchUpInside)
        }
    }
    @IBOutlet weak var likeNumLabel: UILabel!

    
    @objc fileprivate func likeButtonClick(_ sender:UIButton) {
//        likeButton.selected = !likeButton.selected
    }
    
    var model:DayModel? {
        didSet {
            ///处理时间
            let array = self.createDataWithRow(model?.date)
            self.dayLabel.text = array.last
            self.monthAndYearLabel.text = array.first
            self.titleLabel.text = model?.title
        }
    }
    //转化时间格式
    fileprivate func createDataWithRow(_ date:String?) -> [String] {
        var partsArray:[String] = date!.components(separatedBy: CharacterSet(charactersIn: "-"))
        
        var finalArray:[String] = []
        switch partsArray[1] {
        case "01":
            finalArray.append("Jan.2016")
        case "02":
            finalArray.append("Feb.2016")
        case "03":
            finalArray.append("Mar.2016")
        case "04":
            finalArray.append("Apr.2016")
        case "05":
            finalArray.append("May.2016")
        case "06":
            finalArray.append("Jun.2016")
        case "07":
            finalArray.append("Jul.2016")
        case "08":
            finalArray.append("Aug.2016")
        case "09":
            finalArray.append("Sep.2016")
        case "10":
            finalArray.append("Oct.2016")
        case "11":
            finalArray.append("Nov.2016")
        case "12":
            finalArray.append("Dec.2016")
        default:
            finalArray.append("Lily.2016")
        }
        finalArray.append(partsArray[2])
        return  finalArray
    }

    
    
    
    
    class func loadDayWordViewFromXib() -> DayWordView {
        let view = Bundle.main.loadNibNamed("DayWordView", owner: nil, options: nil)?.last as! DayWordView
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
