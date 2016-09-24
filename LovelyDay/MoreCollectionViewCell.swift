//
//  MoreCollectionViewCell.swift
//  LovelyDay
//
//  Created by Elise on 16/5/30.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class MoreCollectionViewCell: UICollectionViewCell {
    
    
    
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    
    var model:MoreCollectModel? {
        didSet {
            self.mainImageView.sd_setImage(with: URL(string: (model?.img)!), placeholderImage:UIImage(named: "quesheng"))
            self.nameLabel.text = model?.name
            self.iconImageView.sd_setImage(with: URL(string: (model?.icon)!))
        }
    }
    
    
    
    
    
    class func loadMoreCollectionViewCellWithViewContro(_ collectionView:UICollectionView,indexPath:IndexPath) -> MoreCollectionViewCell {
        let id = "moreCollectionViewCell"
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? MoreCollectionViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("MoreCollectionViewCell", owner: nil, options: nil)?.last as? MoreCollectionViewCell
        }
        return cell!
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
