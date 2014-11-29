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
    
    var employeeNameString:String? = String()
    var employeeNumberString:String? = String()
    var empNumber:String? = String()
    var barCode:UIImage? = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(true)
        NSUserDefaults.standardUserDefaults().synchronize()
        employeeNameString = NSUserDefaults.standardUserDefaults().stringForKey("employeeName")
        employeeNumberString = NSUserDefaults.standardUserDefaults().stringForKey("employeeNumber")
        empNumber = empNumberToUPC.convertEmpNum(employeeNumberString!)
        barCode = generator.generateCode(empNumber!)
        employeeNameLable.text = employeeNameString!.uppercaseString
        barCodeView.image = barCode
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

