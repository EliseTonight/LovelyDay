//
//  CommentCell.swift
//  LovelyDay
//
//  Created by Elise on 16/5/19.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: CornerImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var blackLineView: UIView!
    
    var model:CommentModel? {
        didSet {
            self.nameLabel.text = model?.name
            self.commentLabel.text = model?.content
            self.iconImageView.sd_setImage(with: URL(string: (model?.head_photo)!), placeholderImage: UIImage(named: "logo_s"))
        }
    }
    
    
    fileprivate func setAutoLayout() {
        self.commentLabel.sd_layout()
        .topSpaceToView(timeLabel,10)?
        .rightEqualToView(timeLabel)?
        .leftEqualToView(timeLabel)?
        .autoHeightRatio(0)
        self.blackLineView.sd_layout()
        .heightIs(1)?
        .widthIs(AppWidth)?
        .bottomSpaceToView(contentView,1)
        self.setupAutoHeight(withBottomView: commentLabel, bottomMargin: 20)
        
        
        self.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
    }
    
    
    
    
    
    
    class func loadCommentCellWithTableView(_ tableView:UITableView) -> CommentCell {
        let id = "commentCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? CommentCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("CommentCell", owner: nil, options: nil)?.last as? CommentCell
        }
        return cell!
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setAutoLayout()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
