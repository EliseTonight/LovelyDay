//
//  NearMapWithCollectionView.swift
//  LovelyDay
//
//  Created by Elise on 16/6/4.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit
public let AnnotionId = "AnnotionId"
public let UserAnnotionId = "UserAnnotionId"
class NearMapWithCollectionView: MAMapView {

    var mapointsAnnotionArray: [MAPointAnnotation] = []
    //记录上次的标记
    var lastMAAnnotationView: MAAnnotationView?
    var model:HomeModels? {
        didSet {
            self.mapointsAnnotionArray.removeAll(keepCapacity: true)
            self.nearCollectionView.reloadData()
            for homeModel in (model?.list)! {
                //把所有数据生成标注,,按type分类,,这边都一样了
                if let position = homeModel.position?.stringToCLLocationCoordinate2D(",") {
                    let point = MAPointAnnotation()
                    point.coordinate = position
                    self.mapointsAnnotionArray.append(point)
                    self.addAnnotation(point)
                }
            }
            self.selectAnnotation(mapointsAnnotionArray[0], animated: true)
        }
    }
    //控制器的weak变量
    weak var selfVC:NearViewController?
    
    
    
    //定位按钮
    private lazy var localButton:UIButton? = {
        let btn = UIButton(frame: CGRectMake(20, AppHeight - 150 - 57 - NavigationHeight, 57, 57))
        btn.setBackgroundImage(UIImage(named: "locate"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "locate"), forState: .Highlighted)
        btn.addTarget(self, action: "currentLocalStart", forControlEvents: .TouchUpInside)
        return btn
    }()
    @objc private func currentLocalStart() {

        self.userTrackingMode = .Follow
        self.setCenterCoordinate(userLocation.coordinate, animated: true)
        self.setZoomLevel(16.1, animated: true)
    }
    
    //底部的collection
    private lazy var nearCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //是uicollection横向移动
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSizeMake(AppWidth - 10, 100)
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        let nearCV = UICollectionView(frame: CGRectMake(0, AppHeight - 50 - 100 - NavigationHeight, AppWidth, 100), collectionViewLayout: layout)
        nearCV.delegate = self
        nearCV.dataSource = self
        nearCV.clipsToBounds = false
        nearCV.pagingEnabled = true
        nearCV.showsVerticalScrollIndicator = false
        nearCV.backgroundColor = UIColor.whiteColor()
        nearCV.registerNib(UINib(nibName: "NearCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "nearCollectionCell")
        return nearCV
    }()
    
    
    //初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        showsCompass = true
        showsScale = false
        showsUserLocation = true
        zoomLevel = 12
        mapType = .Standard
        //提高定位精度
        self.desiredAccuracy = kCLLocationAccuracyBest
        ///初始位置为就近的一个点
        self.setCenterCoordinateWithAnimation("120.313299,30.310014",level: 14)
        
        self.addSubview(nearCollectionView)
        self.addSubview(localButton!)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setCenterCoordinateWithAnimation(position:String,level:Double) {
        if let cllaction2d = position.stringToCLLocationCoordinate2D(",") {
            self.setCenterCoordinate(cllaction2d, animated: true)
            self.setZoomLevel(level, animated: true)
        }
    }
    
    
    
    
    
    
    
    
    
    
}
//map的delegate
extension NearMapWithCollectionView:MAMapViewDelegate {
    //生成annotionview
    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
//        /* 自定义userLocation对应的annotationView. */
//        if annotation.isKindOfClass(MAUserLocation.self) {
//            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(UserAnnotionId) as? MAAnnotationView
//            if annotationView == nil {
//                annotationView = MAAnnotationView(annotation: annotation, reuseIdentifier: UserAnnotionId) as? MAAnnotationView
//            }
//            annotationView?.image = UIImage(named: "myposition")
//            
//            return annotationView
//        }
        if annotation.isKindOfClass(MAPointAnnotation.self) {
            var annot = mapView.dequeueReusableAnnotationViewWithIdentifier(AnnotionId) as? MAPinAnnotationView
            if annot == nil {
                annot = MAPinAnnotationView(annotation: annotation, reuseIdentifier: AnnotionId) as MAPinAnnotationView
            }
            
            annot!.image = UIImage(named: "shoper")
            annot!.center = CGPoint(x: 0, y: -(annot!.image.size.height * 0.5))
            return annot!
        }
        
        return nil
    }
    
    func mapView(mapView: MAMapView!, didSelectAnnotationView view: MAAnnotationView!) {
        lastMAAnnotationView?.image = UIImage(named: "shoper")
        view.image = UIImage(named: "current")
        lastMAAnnotationView = view
        setCenterCoordinate(view.annotation.coordinate, animated: true)
        
        let currentIndex = CGFloat(annotationViewForIndex(view))
        nearCollectionView.setContentOffset(CGPoint(x: currentIndex * nearCollectionView.width, y: 0), animated: true)
    }
    
    private func annotationViewForIndex(annot: MAAnnotationView) -> Int {
        
        for i in 0..<mapointsAnnotionArray.count {
            let po = mapointsAnnotionArray[i]
            if viewForAnnotation(po) === annot {
                return i
            }
        }
        
        return 0
    }
    
}

extension NearMapWithCollectionView:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model?.list?.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell?
        cell = NearCollectionViewCell.loadNearCollectionViewCellWithInfo(collectionView, indexPath: indexPath)
        (cell as? NearCollectionViewCell)?.model = self.model?.list![indexPath.row]
        return cell!
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let vc = HomeDetailViewController()
        vc.model = self.model?.list![indexPath.row]
        self.selfVC?.navigationController?.pushViewController(vc, animated: true)
        
    }
    ///滑动分页，并且切换标注
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(nearCollectionView.contentOffset.x / self.nearCollectionView.size.width + 0.5)
        let currentAnnotion = self.mapointsAnnotionArray[index]
        selectAnnotation(currentAnnotion, animated: true)
    }
    
}











