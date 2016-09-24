//
//  HeadDayView.swift
//  LittleDay3.0
//
//  Created by Elise on 16/5/17.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class HeadDayView: UIView {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    
    
    var model:DayModel? {
        didSet {
            ///处理时间
            let array = self.createDataWithRow(model?.date)
            self.dayLabel.text = array.last
            self.monthLabel.text = array.first
            self.titleLabel.text = model?.title
        }
    }
    //转化时间格式
    fileprivate func createDataWithRow(_ date:String?) -> [String] {
        var partsArray:[String] = date!.components(separatedBy: CharacterSet(charactersIn: "-"))
        
        var finalArray:[String] = []
        switch partsArray[1] {
        case "01":
            finalArray.append("Jan.")
        case "02":
            finalArray.append("Feb.")
        case "03":
            finalArray.append("Mar.")
        case "04":
            finalArray.append("Apr.")
        case "05":
            finalArray.append("May.")
        case "06":
            finalArray.append("Jun.")
        case "07":
            finalArray.append("Jul.")
        case "08":
            finalArray.append("Aug.")
        case "09":
            finalArray.append("Sep.")
        case "10":
            finalArray.append("Oct.")
        case "11":
            finalArray.append("Nov.")
        case "12":
            finalArray.append("Dec.")
        default:
            finalArray.append("Lily.")
        }
        finalArray.append(partsArray[2])
        return  finalArray
    }
    
    
    
    
    class func loadHeadDayViewFromXib() -> HeadDayView {
        let view = Bundle.main.loadNibNamed("HeadDayView", owner: nil, options: nil)?.last as! HeadDayView
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
