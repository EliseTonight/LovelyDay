//
//  NearCollectionViewCell.swift
//  LovelyDay
//
//  Created by Elise on 16/6/5.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class NearCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    
    var model:HomeModel? {
        didSet {
            self.leftImageView.setImageWithURL(NSURL(string: (model?.img)!))
            self.shopNameLabel.text = model?.name
            self.adressLabel.text = model?.address
        }
    }
    
    var distance:String? {
        didSet {
            self.distanceLabel.text = distance
        }
    }
    
    class func loadNearCollectionViewCellWithInfo(collectionView:UICollectionView,indexPath:NSIndexPath) -> NearCollectionViewCell {
        let id = "nearCollectionCell"
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(id, forIndexPath: indexPath) as? NearCollectionViewCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("NearCollectionViewCell", owner: nil, options: nil).last as? NearCollectionViewCell
        }
        return cell!
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
