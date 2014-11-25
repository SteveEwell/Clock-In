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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath:indexPath) as SettingsTableViewCell
        switch indexPath.section {
            case 0:
                cell.textField.text = self.name
            case 1:
                cell.textField.text = self.number
                cell.textField.keyboardType = .NumbersAndPunctuation
            default: break
        }
        cell.textField.delegate = self
        return cell
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        var view:UIView = textField
        do {
            view = view.superview!
        }
        while !(view is UITableViewCell)
        
        let cell = view as SettingsTableViewCell
        
        let indexPath = self.tableView.indexPathForCell(cell)!
        if indexPath.section == 0 {
            self.name = cell.textField.text
        } else if indexPath.section == 1 {
            self.number = cell.textField.text
        }
    }
}