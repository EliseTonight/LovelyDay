//
//  HomeCell.swift
//  LittleDay3.0
//
//  Created by Elise on 16/5/18.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    
    var model:HomeModel? {
        didSet {
            self.backImageView.sd_setImageWithURL(NSURL(string: (model?.img)!), placeholderImage: UIImage(named: "quesheng"))
            self.titleLabel.text = model?.title
            self.infoLabel.text = (model?.name)! + " ・ " + (model?.space?.name)!
        }
    }
    
    
    
    
    
    class func loadHomeCellWithTableView(tableView:UITableView) -> HomeCell {
        let id = "homeCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(id) as? HomeCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("HomeCell", owner: nil, options: nil).last as? HomeCell
        }
        return cell!
        
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame.size.width = AppWidth
        selectionStyle = .None
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
