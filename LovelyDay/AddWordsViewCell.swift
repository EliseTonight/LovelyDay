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
                self.mainLabel.textColor = UIColor.lightGray
            }
            else {
                self.mainLabel.text = model
                self.mainLabel.textColor = UIColor.black
            }
        }
    }
    
    
    
    fileprivate func setAutoLayout() {
        self.mainLabel.sd_layout()
        .leftSpaceToView(contentView,8)?
        .rightSpaceToView(contentView,8)?
        .topSpaceToView(contentView,8)?
        .autoHeightRatio(0)
        self.setupAutoHeight(withBottomView: mainLabel, bottomMargin: 8)
        backView.sd_layout().spaceToSuperView(UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
    }
    
    
    class func loadAddWordsViewCellWithTableView(_ tableView:UITableView) -> AddWordsViewCell {
        let id = "addWordsViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? AddWordsViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("AddWordsViewCell", owner: nil, options: nil)?.last as? AddWordsViewCell
        }
        return cell!
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.setAutoLayout()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
