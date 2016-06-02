//
//  FunDetailTopView.swift
//  LovelyDay
//
//  Created by Elise on 16/5/28.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class FunDetailTopView: UIView {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var positionButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    @IBAction func positionButtonClick(sender: UIButton) {
        
    }
    
    
    var model:FunModel? {
        didSet {
            self.titleLable.text = model?.title
            let dateModel:DataModel? = model?.date
            let timeModel = dateModel?.time_list?.first
            self.timeLabel.text = timeLabelCalculator(timeModel)
            self.adressLabel.text = (model?.address)! + "(" + (model?.poi)! + ")"
        }
    }
    
    //时间模块的解决，，，首先1.起始时间是否与结束时间相同，仅一天，2.是否有weekend，3.其余的,即显示截止日期
    private func timeLabelCalculator(dataModel:TimeListModel?) -> String? {
        var finalTime:String?
        //1
        if dataModel?.end_date == dataModel?.start_date {
            let yearArray = dataModel?.start_date?.componentsSeparatedByString("-")
            let dayArray = dataModel?.start_time?.componentsSeparatedByString(":")
            let dayArrayEnd = dataModel?.end_time?.componentsSeparatedByString(":")
            finalTime = yearArray![1] + "月" + yearArray![2] + "日 " + dayArray![0] + ":" + dayArray![1] + " - " + dayArrayEnd![0] + ":" + dayArrayEnd![1]
        }
        else {
            //2
            if dataModel?.weekdays != "" {
                let weekendArray = dataModel?.weekdays?.componentsSeparatedByString(",")
                var finalWeekStr:String = ""
                for i in 0..<weekendArray!.count {
                    var dayStr = ""
                    if i == 0 {
                        dayStr = dayStr + "每周"
                    }
                    else {
                        dayStr = dayStr + ","
                    }
                    switch weekendArray![i] {
                    case "1":
                        dayStr = dayStr + "一"
                    case "2":
                        dayStr = dayStr + "二"
                    case "3":
                        dayStr = dayStr + "三"
                    case "4":
                        dayStr = dayStr + "四"
                    case "5":
                        dayStr = dayStr + "五"
                    case "6":
                        dayStr = dayStr + "六"
                    case "7":
                        dayStr = dayStr + "日"
                    default:
                        break
                    }
                    finalWeekStr = finalWeekStr + dayStr
                }
                let yearArray = dataModel?.start_date?.componentsSeparatedByString("-")
                let yearArrayEnd = dataModel?.end_date?.componentsSeparatedByString("-")
                let dayArray = dataModel?.start_time?.componentsSeparatedByString(":")
                let dayArrayEnd = dataModel?.end_time?.componentsSeparatedByString(":")
                
                finalTime = yearArray![1] + "月" + yearArray![2] + "日" + " - " + yearArrayEnd![1] + "月" + yearArrayEnd![2] + "日 " + finalWeekStr + " " + dayArray![0] + ":" + dayArray![1] + " - " + dayArrayEnd![0] + ":" + dayArrayEnd![1]
            }
                //3
            else {
                let yearArray = dataModel?.start_date?.componentsSeparatedByString("-")
                let yearArrayEnd = dataModel?.end_date?.componentsSeparatedByString("-")
                let dayArray = dataModel?.start_time?.componentsSeparatedByString(":")
                let dayArrayEnd = dataModel?.end_time?.componentsSeparatedByString(":")
                
                finalTime = yearArray![1] + "月" + yearArray![2] + "日" + " - " + yearArrayEnd![1] + "月" + yearArrayEnd![2] + "日 " + dayArray![0] + ":" + dayArray![1] + " - " + dayArrayEnd![0] + ":" + dayArrayEnd![1]
            }
        }
        return finalTime
    }
    
    
    
    
    
    
    
    
    class func loadFunDetailTopViewFromXib() -> FunDetailTopView {
        let view = NSBundle.mainBundle().loadNibNamed("FunDetailTopView", owner: nil, options: nil).last as? FunDetailTopView
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
