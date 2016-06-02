//
//  NSMutableString+.swift
//  LittleDay
//
//  Created by Elise on 16/3/31.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation
extension NSMutableString {
    
    class func changeHeigthAndWidthWithSrting(searchStr: NSMutableString) -> NSMutableString {
        var mut = [CGFloat]()
        var mutH = [CGFloat]()
        let imageW = AppWidth - 23
        let rxHeight = try! NSRegularExpression(pattern: "(?<= height=\")\\d*", options: NSRegularExpressionOptions.CaseInsensitive)
        let rxWidth = try! NSRegularExpression(pattern: "(?<=width=\")\\d*", options: NSRegularExpressionOptions.CaseInsensitive)
        
        let widthArray = rxWidth.matches(searchStr as String) as! [String]
        
        for width  in widthArray {
            Int(width)!
            mut.append(imageW/CGFloat(Int(width)!))
        }
        
        var widthMatches = rxWidth.matchesInString(searchStr as String, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, searchStr.length))
        
        for var i = widthMatches.count - 1; i >= 0; i-- {
            let widthMatch = widthMatches[i] as NSTextCheckingResult
            searchStr.replaceCharactersInRange(widthMatch.range, withString: "\(imageW)")
        }
        
        let newString = searchStr.mutableCopy() as! NSMutableString
        
        let heightArray = rxHeight.matches(newString as String) as! [String]
        for i in 0..<mut.count {
            mutH.append(mut[i] * CGFloat(Int(heightArray[i])!))
        }
        
        var matches = rxHeight.matchesInString(newString as String, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, newString.length))
        
        for var i = matches.count - 1; i >= 0; i--
        {
            let match = matches[i] as NSTextCheckingResult
            newString.replaceCharactersInRange(match.range, withString: "\(mutH[i])")
        }
        
        return newString
    }
}