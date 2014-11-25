//
//  SettingsViewController.swift
//  Clock In
//
//  Created by Steve Ewell on 11/21/14.
//  Copyright (c) 2014 Steve Ewell. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var employeeName:UITextField!
    @IBOutlet weak var employeeNumber:UITextField!
    @IBOutlet weak var label:UILabel!
    var employeeNameValue:String!
    
    var firstResponder:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        label.text = employeeName.text
    }
    
}