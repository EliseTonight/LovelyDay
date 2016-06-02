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
            self.iconImageView.sd_setImageWithURL(NSURL(string: (model?.head_photo)!), placeholderImage: UIImage(named: "logo_s"))
        }
    }
    
    
    private func setAutoLayout() {
        self.commentLabel.sd_layout()
        .topSpaceToView(timeLabel,10)
        .rightEqualToView(timeLabel)
        .leftEqualToView(timeLabel)
        .autoHeightRatio(0)
        self.blackLineView.sd_layout()
        .heightIs(1)
        .widthIs(AppWidth)
        .bottomSpaceToView(contentView,1)
        self.setupAutoHeightWithBottomView(commentLabel, bottomMargin: 20)
        
        
        self.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
    }
    
    
    
    
    
    
    class func loadCommentCellWithTableView(tableView:UITableView) -> CommentCell {
        let id = "commentCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(id) as? CommentCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CommentCell", owner: nil, options: nil).last as? CommentCell
        }
        return cell!
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        setAutoLayout()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
