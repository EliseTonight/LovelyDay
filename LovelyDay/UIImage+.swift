//
//  UIImage+.swift
//  LovelyDay
//
//  Created by Elise on 16/5/24.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation

extension UIImage {
    func scaleToFitNeedSize(_ fitSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContext(fitSize)
        self.draw(in: CGRect(x: 0, y: 0, width: fitSize.width, height: fitSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
