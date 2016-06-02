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
            self.mainImageView.sd_setImageWithURL(NSURL(string: (model?.img)!), placeholderImage:UIImage(named: "quesheng"))
            self.nameLabel.text = model?.name
            self.iconImageView.sd_setImageWithURL(NSURL(string: (model?.icon)!))
        }
    }
    
    
    
    
    
    class func loadMoreCollectionViewCellWithViewContro(collectionView:UICollectionView,indexPath:NSIndexPath) -> MoreCollectionViewCell {
        let id = "moreCollectionViewCell"
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(id, forIndexPath: indexPath) as? MoreCollectionViewCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("MoreCollectionViewCell", owner: nil, options: nil).last as? MoreCollectionViewCell
        }
        return cell!
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
