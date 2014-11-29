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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        employeeName = nameEditableCell.cellTextField.text
        NSUserDefaults.standardUserDefaults().setValue(employeeName, forKey: "employeeName")
        NSUserDefaults.standardUserDefaults().synchronize()
        textField.resignFirstResponder()
        return true
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
