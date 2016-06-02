//
//  RecommendCell.swift
//  LovelyDay
//
//  Created by Elise on 16/5/22.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class RecommendCell: UITableViewCell {
    
    @IBOutlet weak var addImageView: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: "addImageViewClick")
            addImageView.addGestureRecognizer(tap)
            addImageView.userInteractionEnabled = true
        }
    }
    
    
    
    @IBOutlet weak var titleTextField: UIView!
    
    
    @objc private func addImageViewClick() {
        
    }
    
    
    
    
    
    
    class func loadRecommendCellWithTableView(tableView:UITableView) -> RecommendCell {
        let id = "recommendCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(id) as? RecommendCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("RecommendCell", owner: nil, options: nil).last as? RecommendCell
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
