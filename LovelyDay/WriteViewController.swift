//
//  WriteViewController.swift
//  LovelyDay
//
//  Created by Elise on 16/5/23.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController {

    
    //设置导航栏
    fileprivate func setNavigation() {
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.title = "写点小店打动你的地方"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .done, target: self, action: "cancel")
        let button = UIButton(frame: CGRect(x: 0, y: 20, width: 40, height: 44))
        button.addTarget(self, action: "saveButtonClick", for: UIControlEvents.touchUpInside)
        button.setTitle("保存", for: UIControlState())
        button.setTitleColor(UIColor.black, for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    @objc fileprivate func cancel() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    @objc fileprivate func saveButtonClick() {
        navigationController?.dismiss(animated: true, completion: { () -> Void in
            NotificationCenter.default.post(name: Notification.Name(rawValue: Elise_WordsChange), object: self.mainTextView?.text, userInfo: nil)
        })
    }
    
    //主要的textView
    fileprivate lazy var mainTextView:UITextView? = {
        let mainTextView = UITextView(frame: CGRect(x: 15, y: 15, width: AppWidth - 30, height: AppHeight - NavigationHeight - 30))
        mainTextView.font = UIFont.systemFont(ofSize: 17)
        mainTextView.backgroundColor = UIColor.white
        mainTextView.layer.borderWidth = 1.0
        mainTextView.layer.borderColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 0.5).cgColor
        mainTextView.layer.cornerRadius = 8.0
        mainTextView.layer.masksToBounds = true
        return mainTextView
    }()
    fileprivate func setMainTextView() {
        let view = UIView(frame: MainBounds)
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        self.view.addSubview(view)
        self.view.addSubview(mainTextView!)
        mainTextView?.resignFirstResponder()
    }
    
    
    
    
    
    var model:String? {
        didSet {
            if model != nil {
                self.mainTextView?.text = model
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMainTextView()
        setNavigation()

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
