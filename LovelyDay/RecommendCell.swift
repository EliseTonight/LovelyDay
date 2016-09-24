//
//  RecommendCell.swift
//  LovelyDay
//
//  Created by Elise on 16/5/22.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class RecommendCell: UITableViewCell {
    @IBOutlet weak var defaultLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var addImageView: UIView! 
    //图片的model
    var model:Data? {
        didSet {
            if model != nil {
                defaultLabel.isHidden = true
                self.mainImageView.image = UIImage(data: model!)
            }
            else {
                defaultLabel.isHidden = false
                self.mainImageView.image = UIImage(named: "defaultimage")
            }
        }
    }
    
    
    @IBOutlet weak var titleTextField: UIView!
    

    
    
    
    
    
    class func loadRecommendCellWithTableView(_ tableView:UITableView) -> RecommendCell {
        let id = "recommendCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? RecommendCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("RecommendCell", owner: nil, options: nil)?.last as? RecommendCell
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

