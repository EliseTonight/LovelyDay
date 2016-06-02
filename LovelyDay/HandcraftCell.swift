//
//  HandcraftCell.swift
//  LittleDay3.0
//
//  Created by Elise on 16/5/18.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class HandcraftCell: UITableViewCell {
    
    @IBOutlet weak var headImageView: CornerImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var model:HomeModel? {
        didSet {
            self.headImageView.sd_setImageWithURL(NSURL(string: (model?.head_photo)!), placeholderImage: UIImage(named: "logo_s"))
            self.titleLabel.text = model?.title
            self.nameLabel.text = model?.name
        }
    }
    

    
    
    
    class func loadHandcraftWithTableView(tableView:UITableView) -> HandcraftCell {
        let id = "handcraftCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(id) as? HandcraftCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("HandcraftCell", owner: nil, options: nil).last as? HandcraftCell
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
