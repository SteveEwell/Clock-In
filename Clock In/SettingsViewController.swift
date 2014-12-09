//
//  SettingsViewController.swift
//  Clock In
//
//  Created by Steve Ewell on 11/21/14.
//  Copyright (c) 2014 Steve Ewell. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameCellLabel: UILabel!
    @IBOutlet weak var numberCellLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(true)
        NSUserDefaults.standardUserDefaults().synchronize()
        nameCellLabel.text = NSUserDefaults.standardUserDefaults().stringForKey("employeeName")
        numberCellLabel.text = NSUserDefaults.standardUserDefaults().stringForKey("employeeNumber")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToSettings(segue: UIStoryboardSegue) {
        // Leave empty
    }
    
    
}