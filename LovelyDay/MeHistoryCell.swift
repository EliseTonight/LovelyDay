//
//  MeHistoryCell.swift
//  LovelyDay
//
//  Created by Elise on 16/5/31.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class MeHistoryCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var contentAutoLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var blackLineView: UIView!
    @IBOutlet weak var attachImageView: CornerImageView!
    
    
    
    var model:UserHistoryModel? {
        didSet {
            let date = model?.date
            let array = self.createDataWithRow(date)
            self.dayLabel.text = array[1]
            self.monthLabel.text = array[0]
            self.timeLabel.text = array[2]
            self.contentAutoLabel.text = model?.content
            //这里图片时下载的
            if model?.img == "" {
                self.isHasImage = false
            }
            else {
                self.isHasImage = true
                self.attachImageView.sd_setImage(with: URL(string: (model?.img)!), placeholderImage: UIImage(named: "quesheng"))
            }
            self.autoLayout()
        }
    }
    
    
    fileprivate var isHasImage = false {
        didSet {
            self.attachImageView.isHidden = !isHasImage
        }
    }
    
    //转化时间格式,先分2部分，年与具体时间
    fileprivate func createDataWithRow(_ date:String?) -> [String] {
        var partsArray:[String] = date!.components(separatedBy: CharacterSet(charactersIn: " "))
        var yearArray:[String] = partsArray[0].components(separatedBy: CharacterSet(charactersIn: "-"))
        var timeArray:[String] = partsArray[1].components(separatedBy: CharacterSet(charactersIn: ":"))
        var finalArray:[String] = []
        switch yearArray[1] {
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
        finalArray.append(yearArray[2])
        finalArray.append((timeArray[0] + ":" + timeArray[1]))
        return  finalArray
    }
    
    //自动布局
    fileprivate func autoLayout() {
        self.dayLabel.sd_layout()
        .topSpaceToView(contentView,8)?
        .leftSpaceToView(contentView,8)?
        .widthIs(27)?
        .heightIs(35)
        
        self.monthLabel.sd_layout()
        .leftSpaceToView(dayLabel,0)?
        .topEqualToView(dayLabel)?
        .widthIs(34)?
        .heightIs(35)
        
        self.timeLabel.sd_layout()
        .topSpaceToView(dayLabel,0)?
        .leftEqualToView(dayLabel)?
        .widthIs(60)?
        .heightIs(19)
        
        self.contentAutoLabel.sd_layout()
        .leftSpaceToView(monthLabel,8)?
        .rightSpaceToView(contentView,8)?
        .topSpaceToView(contentView,20)?
        .autoHeightRatio(0)
        
        if self.isHasImage {
            self.attachImageView.sd_layout()
            .rightEqualToView(contentAutoLabel)?
            .leftEqualToView(contentAutoLabel)?
            .heightIs(170)?
            .bottomSpaceToView(contentView,8)
        }
        else {
            
        }
        
        self.blackLineView.sd_layout()
        .rightSpaceToView(contentView,0)?
        .leftSpaceToView(contentView,0)?
        .heightIs(0.5)?
        .bottomSpaceToView(contentView,0.5)
        
        if self.isHasImage {
            self.setupAutoHeight(withBottomView: contentAutoLabel, bottomMargin: 178)
        }
        else {
            self.setupAutoHeight(withBottomView: contentAutoLabel, bottomMargin: 30)
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    class func loadMeHistoryCellWithTableView(_ tableView:UITableView) -> MeHistoryCell {
        let id = "meHistoryCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? MeHistoryCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("MeHistoryCell", owner: nil, options: nil)?.last as? MeHistoryCell
        }
        return cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
