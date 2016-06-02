//
//  ChangeInfoViewController.swift
//  LovelyDay
//
//  Created by Elise on 16/6/1.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class ChangeInfoViewController: UIViewController {
    
    
    var titleType:String? {
        didSet {
            self.title = titleType
        }
    }
    var model:String? {
        didSet {
            
        }
    }
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var changeTextField: UITextField!
    @IBAction func clearButtonClick(sender: UIButton) {
        self.changeTextField.text = ""
        self.clearButton.hidden = true
    }
    @IBOutlet weak var clearButton: UIButton!
    
    @IBAction func changeTextFieldChanged(sender: UITextField) {
        if sender.text != "" && sender.text != nil {
            self.clearButton.hidden = false
        }
        else {
            self.clearButton.hidden = true
        }
    }
    
    private func setRightButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", titleClocr: UIColor.blackColor(), targer: self, action: "saveButtonClick")
    }
    @objc private func saveButtonClick() {
        
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: "ChangeInfoViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.changeTextField.text = model
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
