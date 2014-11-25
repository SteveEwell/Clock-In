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
    let empNumberToUPC:EmpNumberToUPCA = EmpNumberToUPCA()
    
    var employeeName = "Steve"

    override func viewDidLoad() {
        super.viewDidLoad()
        var empNumber = empNumberToUPC.convertEmpNum("478112")
        var barCode:UIImage? = generator.generateCode(empNumber)
        employeeNameLable.text = employeeName.uppercaseString
        barCodeView.image = barCode
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

