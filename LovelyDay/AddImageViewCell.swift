//
//  AddImageViewCell.swift
//  LovelyDay
//
//  Created by Elise on 16/5/22.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class AddImageViewCell: UITableViewCell {
    
    @IBOutlet weak var defaultLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var addImageView: UIView!
    //图片的model
    var model:NSData? {
        didSet {
            if model != nil {
                self.defaultLabel.hidden = true
                self.mainImageView.image = UIImage(data: model!)
            }
            else {
                self.defaultLabel.hidden = false
                self.mainImageView.image = UIImage(named: "defaultimage")
            }
        }
    }
    
    class func loadAddImageViewWithTableView(tableView:UITableView) -> AddImageViewCell {
        let id = "addImageViewCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(id) as? AddImageViewCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("AddImageViewCell", owner: nil, options: nil).last as? AddImageViewCell
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

