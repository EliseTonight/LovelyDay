//
//  MainViewController.swift
//  LittleDay3.0
//
//  Created by Elise on 16/5/17.
//  Copyright © 2016年 Elise. All rights reserved.
//   集成了选择城市的ViewController

import UIKit

class MainViewController: UIViewController {

    var leftButton:titleWithImageButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "cityChange:", name: Elise_CurrentCityChange_Notification, object: nil)
        
        setUI()
        let user = NSUserDefaults.standardUserDefaults()
        if let inCity = user.objectForKey(Elise_Current_SelectedCity) as? String {
            leftButton?.setTitle(inCity, forState: .Normal)
        }
        else {
            leftButton?.setTitle("杭州", forState: .Normal)
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func setUI() {
        leftButton = titleWithImageButton(frame: CGRectMake(0, 20, 80, 44))
        self.leftButton?.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.leftButton?.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.leftButton?.setImage(UIImage(named: "city_1"), forState: .Normal)
        self.leftButton?.addTarget(self, action: "pushCityView:", forControlEvents: .TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton!)
    }
    func pushCityView(button:UIButton) {
        let cityView = CitySelectViewController()
        cityView.cityName = leftButton?.titleForState(.Normal)
        let navigationView = MainNavigationController(rootViewController:cityView)
        presentViewController(navigationView, animated: true, completion: nil)
    }
    
    func cityChange(notice:NSNotification) {
        if let changeCityName = notice.object as? String {
            leftButton?.setTitle(changeCityName, forState: .Normal)
        }
    }
    //销毁监听器
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
