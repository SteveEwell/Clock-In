//
//  EditNameViewController.swift
//  Clock In
//
//  Created by Steve Ewell on 11/27/14.
//  Copyright (c) 2014 Steve Ewell. All rights reserved.
//

import UIKit

class EditNameViewController: UITableViewController {
    
    var employeeName:String = String()
    

    @IBOutlet weak var nameEditableCell: SettingsEditableCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameEditableCell.cellTextField.text = NSUserDefaults.standardUserDefaults().stringForKey("employeeName")

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        employeeName = nameEditableCell.cellTextField.text
        if (employeeName.length() > 26 || employeeName.length() == 0) {
            NSUserDefaults.standardUserDefaults().synchronize()
        } else {
            NSUserDefaults.standardUserDefaults().setValue(employeeName, forKey: "employeeName")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        employeeName = nameEditableCell.cellTextField.text
        if (employeeName.length() > 26 || employeeName.length() == 0) {
            let alert = UIAlertController(title: "Name is too long or too short!", message: "Entered names must be between 1 and 26 characters long.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: alertHandler))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            NSUserDefaults.standardUserDefaults().setValue(employeeName, forKey: "employeeName")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        textField.resignFirstResponder()
        return true
    }
    
    func alertHandler(act:UIAlertAction!) {
        NSUserDefaults.standardUserDefaults().setValue("Name", forKey: "employeeName")
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
