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
    var model:Data? {
        didSet {
            if model != nil {
                self.defaultLabel.isHidden = true
                self.mainImageView.image = UIImage(data: model!)
            }
            else {
                self.defaultLabel.isHidden = false
                self.mainImageView.image = UIImage(named: "defaultimage")
            }
        }
    }
    
    class func loadAddImageViewWithTableView(_ tableView:UITableView) -> AddImageViewCell {
        let id = "addImageViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? AddImageViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("AddImageViewCell", owner: nil, options: nil)?.last as? AddImageViewCell
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

