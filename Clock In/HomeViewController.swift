//
//  ViewController.swift
//  Clock In
//
//  Created by Steve Ewell on 11/1/14.
//  Copyright (c) 2014 Steve Ewell. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var barCodeView: UIImageView!
    @IBOutlet weak var employeeNameLable: UILabel!
    
    let generator:CoreGenerator = CoreGenerator()
    
    var employeeName = "Steve"

    override func viewDidLoad() {
        super.viewDidLoad()
        var barCode:UIImage? = generator.generateCode("0000004781127")
        employeeNameLable.text = employeeName.uppercaseString
        barCodeView.image = barCode
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

