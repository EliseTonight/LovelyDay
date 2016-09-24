//
//  NSMutableString+.swift
//  LittleDay
//
//  Created by Elise on 16/3/31.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation
extension NSMutableString {
    
    class func changeHeigthAndWidthWithSrting(_ searchStr: NSMutableString) -> NSMutableString {
        var mut = [CGFloat]()
        var mutH = [CGFloat]()
        let imageW = AppWidth - 23
        let rxHeight = try! NSRegularExpression(pattern: "(?<= height=\")\\d*", options: NSRegularExpression.Options.caseInsensitive)
        let rxWidth = try! NSRegularExpression(pattern: "(?<=width=\")\\d*", options: NSRegularExpression.Options.caseInsensitive)
        
        let widthArray = rxWidth.matches(searchStr as String) as! [String]
        
        for width  in widthArray {
            mut.append(imageW/CGFloat(Int(width)!))
        }
        
        var widthMatches = rxWidth.matches(in: searchStr as String, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, searchStr.length))
        
        var iIndex = widthMatches.count - 1
        while iIndex >= 0 {
            let widthMatch = widthMatches[iIndex] as NSTextCheckingResult
            searchStr.replaceCharacters(in: widthMatch.range, with: "\(imageW)")
            iIndex -= 1;
        }
        
//        for i in widthMatches.count - 1...0 {
//            let widthMatch = widthMatches[i] as NSTextCheckingResult
//            searchStr.replaceCharacters(in: widthMatch.range, with: "\(imageW)")
//        }
        
        let newString = searchStr.mutableCopy() as! NSMutableString
        
        let heightArray = rxHeight.matches(newString as String) as! [String]
        for i in 0..<mut.count {
            mutH.append(mut[i] * CGFloat(Int(heightArray[i])!))
        }
        
        var matches = rxHeight.matches(in: newString as String, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, newString.length))
        
        var jIndex = matches.count - 1
        while jIndex >= 0 {
            let match = matches[jIndex] as NSTextCheckingResult
            newString.replaceCharacters(in: match.range, with: "\(mutH[jIndex])")
            jIndex -= 1;
        }
        
//        for i in matches.count - 1...0    {
//            let match = matches[i] as NSTextCheckingResult
//            newString.replaceCharacters(in: match.range, with: "\(mutH[i])")
//        }
        
        return newString
    }
}
