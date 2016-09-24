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
            self.mapointsAnnotionArray.removeAll(keepingCapacity: true)
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
    fileprivate lazy var localButton:UIButton? = {
        let btn = UIButton(frame: CGRect(x: 20, y: AppHeight - 150 - 57 - NavigationHeight, width: 57, height: 57))
        btn.setBackgroundImage(UIImage(named: "locate"), for: UIControlState())
        btn.setBackgroundImage(UIImage(named: "locate"), for: .highlighted)
        btn.addTarget(self, action: #selector(NearMapWithCollectionView.currentLocalStart), for: .touchUpInside)
        return btn
    }()
    @objc fileprivate func currentLocalStart() {

        self.userTrackingMode = .follow
        self.setCenter(userLocation.coordinate, animated: true)
        self.setZoomLevel(16.1, animated: true)
    }
    
    //底部的collection
    fileprivate lazy var nearCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //是uicollection横向移动
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: AppWidth - 10, height: 100)
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        let nearCV = UICollectionView(frame: CGRect(x: 0, y: AppHeight - 50 - 100 - NavigationHeight, width: AppWidth, height: 100), collectionViewLayout: layout)
        nearCV.delegate = self
        nearCV.dataSource = self
        nearCV.clipsToBounds = false
        nearCV.isPagingEnabled = true
        nearCV.showsVerticalScrollIndicator = false
        nearCV.backgroundColor = UIColor.white
        nearCV.register(UINib(nibName: "NearCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "nearCollectionCell")
        return nearCV
    }()
    
    
    //初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        showsCompass = true
        showsScale = false
        isShowsUserLocation = true
        zoomLevel = 12
        mapType = .standard
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
    fileprivate func setCenterCoordinateWithAnimation(_ position:String,level:Double) {
        if let cllaction2d = position.stringToCLLocationCoordinate2D(",") {
            self.setCenter(cllaction2d, animated: true)
            self.setZoomLevel(level, animated: true)
        }
    }
    
    
    
    
    
    
    
    
    
    
}
//map的delegate
extension NearMapWithCollectionView:MAMapViewDelegate {
    //生成annotionview
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
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
        if annotation.isKind(of: MAPointAnnotation.self) {
            var annot = mapView.dequeueReusableAnnotationView(withIdentifier: AnnotionId) as? MAPinAnnotationView
            if annot == nil {
                annot = MAPinAnnotationView(annotation: annotation, reuseIdentifier: AnnotionId) as MAPinAnnotationView
            }
            
            annot!.image = UIImage(named: "shoper")
            annot!.center = CGPoint(x: 0, y: -(annot!.image.size.height * 0.5))
            return annot!
        }
        
        return nil
    }
    
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        lastMAAnnotationView?.image = UIImage(named: "shoper")
        view.image = UIImage(named: "current")
        lastMAAnnotationView = view
        setCenter(view.annotation.coordinate, animated: true)
        
        let currentIndex = CGFloat(annotationViewForIndex(view))
        nearCollectionView.setContentOffset(CGPoint(x: currentIndex * nearCollectionView.width, y: 0), animated: true)
    }
    
    fileprivate func annotationViewForIndex(_ annot: MAAnnotationView) -> Int {
        
        for i in 0..<mapointsAnnotionArray.count {
            let po = mapointsAnnotionArray[i]
            if view(for: po) === annot {
                return i
            }
        }
        
        return 0
    }
    
}

extension NearMapWithCollectionView:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model?.list?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell?
        cell = NearCollectionViewCell.loadNearCollectionViewCellWithInfo(collectionView, indexPath: indexPath)
        (cell as? NearCollectionViewCell)?.model = self.model?.list![(indexPath as NSIndexPath).row]
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HomeDetailViewController()
        vc.model = self.model?.list![(indexPath as NSIndexPath).row]
        self.selfVC?.navigationController?.pushViewController(vc, animated: true)
        
    }
    ///滑动分页，并且切换标注
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(nearCollectionView.contentOffset.x / self.nearCollectionView.size.width + 0.5)
        let currentAnnotion = self.mapointsAnnotionArray[index]
        selectAnnotation(currentAnnotion, animated: true)
    }
    
}











