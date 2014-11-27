//
//  SettingsEditableCell.swift
//  Clock In
//
//  Created by Steve Ewell on 11/27/14.
//  Copyright (c) 2014 Steve Ewell. All rights reserved.
//

import UIKit

class SettingsEditableCell: UITableViewCell {
    
    @IBOutlet weak var cellTextField:UITextField!
    
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
