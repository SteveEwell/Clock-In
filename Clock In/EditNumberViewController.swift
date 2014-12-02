//
//  EditNumberViewController.swift
//  Clock In
//
//  Created by Steve Ewell on 11/27/14.
//  Copyright (c) 2014 Steve Ewell. All rights reserved.
//

import UIKit

class EditNumberViewController: UITableViewController {

    @IBOutlet weak var numberEditableCell: SettingsEditableCell!
    
    var keyboardToolbar:UIToolbar = UIToolbar()
    var flexBarButton:UIBarButtonItem = UIBarButtonItem()
    var doneButton:UIBarButtonItem = UIBarButtonItem()
    
    
    var employeeNumber:String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeeNumber = NSUserDefaults.standardUserDefaults().stringForKey("employeeNumber")!
        numberEditableCell.cellTextField.text = employeeNumber
        
        keyboardToolbar.sizeToFit()
        
        flexBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doneClicked:")
        
        keyboardToolbar.items = [flexBarButton, doneButton]
        self.numberEditableCell.cellTextField.inputAccessoryView = keyboardToolbar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doneClicked(AnyObject) {
        employeeNumber = numberEditableCell.cellTextField.text
        if (employeeNumber.length() > 12 || employeeNumber.length() == 0) {
            let alert = UIAlertController(title: "Number out of range!", message: "Enter a number between 1 and 999999.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: alertHandler))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            NSUserDefaults.standardUserDefaults().setValue(employeeNumber, forKey: "employeeNumber")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        self.view.endEditing(true)
    }
    
    func alertHandler(act:UIAlertAction!) {
        NSUserDefaults.standardUserDefaults().setValue("123456", forKey: "employeeNumber")
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
