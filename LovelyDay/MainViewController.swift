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
        
        NotificationCenter.default.addObserver(self, selector: "cityChange:", name: NSNotification.Name(rawValue: Elise_CurrentCityChange_Notification), object: nil)
        
        setUI()
        let user = UserDefaults.standard
        if let inCity = user.object(forKey: Elise_Current_SelectedCity) as? String {
            leftButton?.setTitle(inCity, for: UIControlState())
        }
        else {
            leftButton?.setTitle("杭州", for: UIControlState())
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    fileprivate func setUI() {
        leftButton = titleWithImageButton(frame: CGRect(x: 0, y: 20, width: 80, height: 44))
        self.leftButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.leftButton?.setTitleColor(UIColor.black, for: UIControlState())
        self.leftButton?.setImage(UIImage(named: "city_1"), for: UIControlState())
        self.leftButton?.addTarget(self, action: "pushCityView:", for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton!)
    }
    func pushCityView(_ button:UIButton) {
        let cityView = CitySelectViewController()
        cityView.cityName = leftButton?.title(for: UIControlState())
        let navigationView = MainNavigationController(rootViewController:cityView)
        present(navigationView, animated: true, completion: nil)
    }
    
    func cityChange(_ notice:Notification) {
        if let changeCityName = notice.object as? String {
            leftButton?.setTitle(changeCityName, for: UIControlState())
        }
    }
    //销毁监听器
    deinit {
        NotificationCenter.default.removeObserver(self)
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
