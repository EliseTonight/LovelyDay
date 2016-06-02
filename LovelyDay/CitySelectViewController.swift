//
//  CitySelectViewController.swift
//  LittleDay
//
//  Created by Elise on 16/3/13.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit


//city选择的view
class CitySelectViewController: UIViewController {

    var cityName:String?
    var collectionView:UICollectionView?
    var collectionLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    lazy var domesticCity:NSMutableArray? = {
        let domesticCity = NSMutableArray(array: ["北京", "潮汕", "成都", "重庆", "大连", "广州", "杭州", "徽州", "景德镇", "昆明", "南京", "厦门", "上海", "深圳", "苏州", "台北", "武汉", "西安", "扬州"])
        return domesticCity
    }()
    lazy var overseaCity:NSMutableArray? = {
        let overseaCity = NSMutableArray(array: ["巴黎", "柏林", "迪拜", "里斯本", "伦敦", "罗马", "东京", "熊本", "汉城"])
        return overseaCity
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        setCollection()
        //进入时遍历一遍，确定上次的选择的位置
        let lastSelected:NSIndexPath = self.currentSelectedCity()
//        print(lastSelected.row)
//        print(lastSelected.section)
        collectionView?.selectItemAtIndexPath(lastSelected, animated: true, scrollPosition: .None)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //现在选择的城市
    private func currentSelectedCity() -> NSIndexPath {
        if let currentSelected = cityName {
            var i = 0
            for city in domesticCity! {
                if currentSelected == (city as! String) {
                    return NSIndexPath(forItem: i, inSection: 0)
                }
                else {
                    i++
                }
            }
            i = 0
            for city in overseaCity! {
                if currentSelected == (city as! String) {
                    return NSIndexPath(forItem: i, inSection: 1)
                }
                else {
                    i++
                }
            }
        }
        return NSIndexPath(forItem: 0, inSection: 0)
    }

    func setNavigation() {
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.title = "选择城市"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Done, target: self, action: "cancel")
    }
    func cancel() {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    //collectionView的设置方式
    private func setCollection() {
        //设置layout
        let itemWidth:CGFloat = AppWidth / 3.0 - 1.0
        let itemHeight:CGFloat = 50
        
        collectionLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        //行间距
        collectionLayout.minimumLineSpacing = 1.0
        //cell间距
        collectionLayout.minimumInteritemSpacing = 1.0
        //每一个
        collectionLayout.headerReferenceSize = CGSize(width: AppWidth, height: 60)
        
        //设置collectionView
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionLayout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        collectionView?.selectItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 0), animated: true, scrollPosition: .None)
        //注册项
        //anyclass表示元类型，，.self可以获得类型本身，或者实例本身
        //register优点在于重用时，如果取出为空，则会自动创建
        collectionView?.registerClass(CityCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.registerClass(CityCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headView")
        collectionView?.registerClass(CityCollectionFootResusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footView")
        self.view.addSubview(collectionView!)
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
//拓展协议
extension CitySelectViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    //每个Section部分的Items
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return (domesticCity?.count)!
        }
        else {
            return (overseaCity?.count)!
        }
    }
    //2个Section
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    //生成Items
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:CityCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CityCollectionViewCell
        //indexPath是对应section里的标号
        if indexPath.section == 0 {
            cell.cityName = domesticCity![indexPath.row] as! String
        }else {
            cell.cityName = overseaCity?.objectAtIndex(indexPath.row) as! String
        }
        return cell
    }
    //生成每个Section的headView与footView
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionFooter && indexPath.row == 1 {
            let footView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "footView", forIndexPath: indexPath) as? CityCollectionFootResusableView
            footView!.frame.size.height = 80
            return footView!
        }
        else {
            let headView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headView", forIndexPath: indexPath) as? CityCollectionReusableView
            if indexPath.row == 0 {
                headView?.headTitle = "国内城市"
            }
            else {
                headView?.headTitle = "国外城市"
            }
            return headView!
        }
    }
    //选择城市
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cellSelected = collectionView.cellForItemAtIndexPath(indexPath) as? CityCollectionViewCell
        let currentCityName = cellSelected?.cityName
        //个人数据
        let user = NSUserDefaults.standardUserDefaults()
        //存储当前选择
        user.setObject(currentCityName, forKey: Elise_Current_SelectedCity)
        //选择后立即同步并返回
        if user.synchronize() {
            NSNotificationCenter.defaultCenter().postNotificationName(Elise_CurrentCityChange_Notification, object: currentCityName)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    //footView的Layout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSizeZero
        }
        else {
            return CGSize(width: view.frame.width, height: 120)
        }
    }
    
}

