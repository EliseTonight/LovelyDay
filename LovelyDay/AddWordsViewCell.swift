//
//  AddWordsViewCell.swift
//  LovelyDay
//
//  Created by Elise on 16/5/22.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class AddWordsViewCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    
    var model:String? {
        didSet {
            if model == nil || model == "" {
                self.mainLabel.text = "写点小店打动你的地方"
                self.mainLabel.textColor = UIColor.lightGrayColor()
            }
            else {
                self.mainLabel.text = model
                self.mainLabel.textColor = UIColor.blackColor()
            }
        }
    }
    
    
    
    private func setAutoLayout() {
        self.mainLabel.sd_layout()
        .leftSpaceToView(contentView,0)
        .rightSpaceToView(contentView,0)
        .autoHeightRatio(0)
        self.setupAutoHeightWithBottomView(mainLabel, bottomMargin: 8)
        backView.sd_layout().spaceToSuperView(UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
    }
    
    
    class func loadAddWordsViewCellWithTableView(tableView:UITableView) -> AddWordsViewCell {
        let id = "addWordsViewCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(id) as? AddWordsViewCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("AddWordsViewCell", owner: nil, options: nil).last as? AddWordsViewCell
        }
        return cell!
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        self.setAutoLayout()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
