//
//  SettingsViewController.swift
//  Clock In
//
//  Created by Steve Ewell on 11/21/14.
//  Copyright (c) 2014 Steve Ewell. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, UITextFieldDelegate {
    
    var name = "Steve"
    var number = "478112"
    @IBOutlet weak var nameCellLabel: UILabel!
    @IBOutlet weak var numberCellLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameCellLabel.text = name
        numberCellLabel.text = number
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}