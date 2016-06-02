//
//  FunCell.swift
//  LovelyDay
//
//  Created by Elise on 16/5/18.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class FunCell: UITableViewCell {
    
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    var model:FunModel? {
        didSet {
            self.titleLabel.text = model?.title
            self.mainImageView.sd_setImageWithURL(NSURL(string: (model?.imgs?.first)!), placeholderImage: UIImage(named: "quesheng"))
            let dateModel:DataModel? = model?.date
            let timeModel = dateModel?.time_list?.first
            self.timeLabel.text = timeLabelCalculator(timeModel)! + " | " + (model?.tag)!
            
        }
    }
    
    //时间模块的解决，，，首先1.起始时间是否与结束时间相同，仅一天，2.是否有weekend，3.其余的,即显示截止日期
    private func timeLabelCalculator(dataModel:TimeListModel?) -> String? {
        var finalTime:String?
        //1
        if dataModel?.end_date == dataModel?.start_date {
            let yearArray = dataModel?.start_date?.componentsSeparatedByString("-")
            let dayArray = dataModel?.start_time?.componentsSeparatedByString(":")
            finalTime = yearArray![1] + "月" + yearArray![2] + "日 " + dayArray![0] + ":" + dayArray![1]
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
                let dayArray = dataModel?.start_time?.componentsSeparatedByString(":")
                finalTime = finalWeekStr + " " + dayArray![0] + ":" + dayArray![1]
            }
            //3
            else {
                let  yearArray = dataModel?.end_date?.componentsSeparatedByString("-")
                finalTime = "截止至" + yearArray![1] + "月" + yearArray![2] + "日"
            }
        }
        return finalTime
    }
    
    
    
    
    
    
    
    
    class func loadFunCellWithTableView(tableView:UITableView) -> FunCell {
        let id = "funCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(id) as? FunCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("FunCell", owner: nil, options: nil).last as? FunCell
        }
        return cell!
    }
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
