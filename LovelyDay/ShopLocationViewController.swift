//
//  ShopLocationViewController.swift
//  LovelyDay
//
//  Created by Elise on 16/6/4.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

//定位的mapview
class ShopLocationViewController: UIViewController {

    
    var model:HomeModel? {
        didSet {
            if let shopLocationTude = model?.position?.stringToCLLocationCoordinate2D(",") {
                let point = MAPointAnnotation()
                point.coordinate = shopLocationTude
                self.gdMapView?.addAnnotation(point)
                self.gdMapView?.setCenter(shopLocationTude, animated: true)
                self.gdMapView?.setZoomLevel(15, animated: true)
                
            }
        }
    }
    
    //高德地图的mapview
    fileprivate lazy var gdMapView:MAMapView? = {
        let gdMapView = MAMapView(frame: MainBounds)
        gdMapView.delegate = self
        gdMapView.showsCompass = true
        gdMapView.showsScale = false
        gdMapView.isShowsUserLocation = true
        gdMapView.setZoomLevel(14, animated: true)
        return gdMapView
    }()
    
    fileprivate func setMapView() {
        self.title = "小店位置"
        self.view.addSubview(gdMapView!)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setMapView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        gdMapView?.isShowsUserLocation = false
        //报错，Enqueed from com.apple.main-thread(Thread1)
//        gdMapView?.clearDisk()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ShopLocationViewController:MAMapViewDelegate {
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        //应当根据type来设置不同的图片
        var annot = mapView.dequeueReusableAnnotationView(withIdentifier: "point") as? CustomAnnotationView
        if annot == nil {
            annot = CustomAnnotationView(annotation: annotation, reuseIdentifier: "point") as CustomAnnotationView
        }
        annot!.isUserInteractionEnabled = false
        annot!.setSelected(true, animated: true)
        annot!.canShowCallout = false
        annot!.image = UIImage(named: "shoper")
        annot!.center = CGPoint(x: 0, y: -(annot!.image.size.height * 0.5))
        annot!.calloutView?.model = model
        return annot!

    }
}











