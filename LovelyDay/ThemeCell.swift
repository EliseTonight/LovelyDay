//
//  ThemeCell.swift
//  LovelyDay
//
//  Created by Elise on 16/5/29.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class ThemeCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var autoHeightContentLabel: UILabel!
    @IBOutlet weak var adressView: UIView!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var whiteView: UIView!
    
    
    ///主要的model
    var model:HomeModel? {
        didSet {
            self.subTitleLabel.text = model?.title
            self.autoHeightContentLabel.text = model?.detail
            self.adressLabel.text = model?.address
            self.titleLabel.text = model?.name
            self.mainImageView.sd_setImage(with: URL(string: (model?.img)!), placeholderImage: UIImage(named: "quesheng"))
            
        }
    }
    
    ///autoLayout
    fileprivate func autoLayoutThemeCell() {
        
        self.titleLabel.sd_layout()
        .topSpaceToView(contentView,8)?
        .rightSpaceToView(contentView,8)?
        .leftSpaceToView(contentView,8)?
        .heightIs(23)
        
        self.subTitleLabel.sd_layout()
        .topSpaceToView(titleLabel,0)?
        .rightEqualToView(titleLabel)?
        .leftEqualToView(titleLabel)?
        .heightIs(21)
        
        self.mainImageView.sd_layout()
        .topSpaceToView(subTitleLabel,8)?
        .rightEqualToView(subTitleLabel)?
        .leftEqualToView(subTitleLabel)?
        .heightIs(180)
        
        self.autoHeightContentLabel.sd_layout()
        .topSpaceToView(mainImageView,10)?
        .leftEqualToView(mainImageView)?
        .rightEqualToView(mainImageView)?
        .autoHeightRatio(0)
        
        self.adressView.sd_layout()
        .rightEqualToView(autoHeightContentLabel)?
        .leftEqualToView(autoHeightContentLabel)?
        .heightIs(36)?
        .bottomSpaceToView(contentView,8)
        
        self.setupAutoHeight(withBottomView: autoHeightContentLabel, bottomMargin: 70)
        self.whiteView.sd_layout()
        .spaceToSuperView(UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
        
        
    }
    
    class func loadThemeCellWithTableView(_ tableView:UITableView) -> ThemeCell {
        let id = "themeCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? ThemeCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("ThemeCell", owner: nil, options: nil)?.last as? ThemeCell
        }
        return cell!
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.autoLayoutThemeCell()
        selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
