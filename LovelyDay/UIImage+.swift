//
//  UIImage+.swift
//  LovelyDay
//
//  Created by Elise on 16/5/24.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation

extension UIImage {
    func scaleToFitNeedSize(fitSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContext(fitSize)
        self.drawInRect(CGRectMake(0, 0, fitSize.width, fitSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}