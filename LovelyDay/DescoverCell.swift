//
//  DescoverCell.swift
//  LovelyDay
//
//  Created by Elise on 16/5/29.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class DescoverCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var model:DescoverModel? {
        didSet {
            self.titleLabel.text = model?.title
            self.mainImageView.sd_setImageWithURL(NSURL(string: (model?.img)!), placeholderImage: UIImage(named: "quesheng"))
        }
    }
    
    
    
    
    
    
    class func loadDescoverCellWithTableView(tableView:UITableView) -> DescoverCell {
        let id = "descoverCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(id) as? DescoverCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("DescoverCell", owner: nil, options: nil).last as? DescoverCell
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
