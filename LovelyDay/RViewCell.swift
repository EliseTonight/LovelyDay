//
//  LViewCell.swift
//  LovelyDay
//
//  Created by Elise on 16/5/20.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class RViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    
    
    var model:ArticleModel? {
        didSet {
            self.titleLabel.text = model?.title
            self.fromLabel.text = model?.from
            if model?.img == "" || model?.img == nil {
                self.mainImageView.isHidden = true
            }
            else {
                self.mainImageView.sd_setImage(with: URL(string: (model?.img)!), placeholderImage: UIImage(named: "quesheng"))
            }
        }
    }
    
    
    
    
    
    class func loadLViewCellWithTableView(_ tableView:UITableView) -> RViewCell {
        let id = "rViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? RViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("RViewCell", owner: nil, options: nil)?.last as? RViewCell
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
