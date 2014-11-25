//
//  SettingsTableViewCell.swift
//  Clock In
//
//  Created by Steve Ewell on 11/25/14.
//  Copyright (c) 2014 Steve Ewell. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textField:UITextField!
    
    override func didTransitionToState(state: UITableViewCellStateMask) {
        let editing = UITableViewCellStateMask.ShowingEditControlMask.rawValue
        if state.rawValue & editing != 0 {
            self.textField.enabled = true
        }
        else {
            self.textField.enabled = false
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
