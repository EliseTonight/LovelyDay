//
//  MeiWenCell.swift
//  LittleDay3.0
//
//  Created by Elise on 16/5/18.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class MeiWenCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    
    var model:HomeModel? {
        didSet {
            self.titleLabel.text = model?.title
        }
    }
    
    
    
    
    class func loadMeiWenCellWithTableView(tableView:UITableView) -> MeiWenCell {
        let id = "meiWenCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(id) as? MeiWenCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("MeiWenCell", owner: nil, options: nil).last as? MeiWenCell
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
