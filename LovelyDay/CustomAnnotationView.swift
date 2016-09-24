//
//  CustomAnnotationView.swift
//  LovelyDay
//
//  Created by Elise on 16/6/4.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class CustomAnnotationView: MAAnnotationView {

    var calloutView: BubbleLocationView?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        calloutView = BubbleLocationView(frame: CGRect(x: 0, y: 0, width: AppWidth - 50, height: 60))
        calloutView!.center = CGPoint(x: self.bounds.width * 0.5 + calloutOffset.x + 12,
                                          y: -calloutView!.bounds.height * 0.5 + calloutOffset.y)
        addSubview(calloutView!)
    }
}
