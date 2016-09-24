//
//  MoreViewController.swift
//  LovelyDay
//
//  Created by Elise on 16/5/30.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class MoreViewController: MainViewController {
    
    //collection的model
    var model:MoreCollectModels? {
        didSet {
            
        }
    }
    
    
    
    
    
    ///主要的collectionView
    fileprivate lazy var mainCollectionViewLayout:UICollectionViewFlowLayout? = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        var itemW = (AppWidth - 3 * 8) / 2 - 1
        var itemH:CGFloat = 130
        layout.itemSize = CGSize(width: itemW, height: itemH)
        return layout
    }()
    fileprivate var mainCollectionView:UICollectionView?
    fileprivate func setCollectionView() {
        self.mainCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight - NavigationHeight), collectionViewLayout: self.mainCollectionViewLayout!)
        mainCollectionView?.backgroundColor = UIColor(red: 245/255, green:  245/255, blue:  245/255, alpha: 1.0)
        mainCollectionView?.delegate = self
        mainCollectionView?.dataSource = self
        mainCollectionView?.alwaysBounceVertical = true
        mainCollectionView?.showsHorizontalScrollIndicator = false
        mainCollectionView?.showsVerticalScrollIndicator = false
        mainCollectionView?.register(UINib(nibName: "MoreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "moreCollectionViewCell")
        view.addSubview(mainCollectionView!)
        
        //设置刷新头部
        self.setCollectionRefreshAnimation(self, refreshingAction: #selector(MoreViewController.loadData), gifFrame: CGRect(x: (AppWidth - RefreshImage_Width) * 0.5, y: 10, width: RefreshImage_Width, height: RefreshImage_Height), targetCollectionView: mainCollectionView!)
    }
    
    //下拉刷新动画
    fileprivate func setCollectionRefreshAnimation(_ refreshingTarget:AnyObject!,refreshingAction:Selector,gifFrame:CGRect,targetCollectionView:UICollectionView) {
        let header = LDRefreshHeader(refreshingTarget: refreshingTarget, refreshingAction: refreshingAction)
        header?.gifView?.frame = gifFrame
        targetCollectionView.mj_header = header
    }
    //下拉加载数据动画，下拉会自动触发，已封装
    @objc fileprivate func loadData() {
        //闭包中使用self的引用会引起内存泄露，weak可以解决
        //另一种 ： 设置delegate时
        weak var selfRefer = self
        //模拟多线程的后台加载数据
        //设定时间
        let time = DispatchTime.now() + Double(Int64(0.6 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        //延迟一段时间后执行，模拟加载时间，queue：提交到的队列
        DispatchQueue.main.asyncAfter(deadline: time) { () -> Void in
            MoreCollectModels.loadMoreCollectModels({ (data, error) -> () in
                if data == nil {
                    SVProgressHUD.showError(withStatus: "网络不给力")
                    selfRefer?.mainCollectionView?.mj_header.endRefreshing()
                }
                else {
                    selfRefer?.model = data
                    selfRefer?.mainCollectionView?.reloadData()
                    selfRefer?.mainCollectionView?.mj_header.endRefreshing()
                }
            })
        }
    }
    
    
    
    
    
    lazy var backButton:UIButton = {
        let backButton:UIButton = UIButton(type: .custom)
        backButton.setTitleColor(UIColor.black, for: UIControlState())
        backButton.setTitleColor(UIColor.gray, for: .highlighted)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        backButton.setImage(UIImage(named: "back_1"), for: UIControlState())
        backButton.setImage(UIImage(named: "back_2"), for: .highlighted)
        backButton.contentHorizontalAlignment = .left
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0)
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        let backButtonWidth: CGFloat = AppWidth > 375.0 ? 50 : 44
        backButton.frame = CGRect(x: 0, y: 0, width: backButtonWidth, height: 40)
        backButton.addTarget(self, action: #selector(MoreViewController.turnBack(_:)), for: .touchUpInside)
        return backButton
    }()
    @objc fileprivate func turnBack(_ sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "分类"
        setCollectionView()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        self.mainCollectionView?.mj_header.beginRefreshing()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension MoreViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.model?.list?.count ?? 0)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell?
        cell = MoreCollectionViewCell.loadMoreCollectionViewCellWithViewContro(collectionView, indexPath: indexPath)
        (cell as? MoreCollectionViewCell)?.model = self.model?.list![(indexPath as NSIndexPath).row]
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TopDetailCommonViewController()
        vc.headTitle = self.model?.list![(indexPath as NSIndexPath).row].name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
















