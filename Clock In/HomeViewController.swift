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
    var firstLaunch:Bool? = Bool()
    var empNumber:String? = String()
    var barCode:UIImage? = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("firstLaunch")
        if (firstLaunch == true) {
            let alert = UIAlertController(title: "Disclamer!", message: "This app is not a replacement for your company provided clock-in/clock-out method. It is intended for convenience only. Please contact your companies HR representative for specific rules regarding this apps usage.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: alertHandler))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(true)
        NSUserDefaults.standardUserDefaults().synchronize()
        employeeNameString = NSUserDefaults.standardUserDefaults().stringForKey("employeeName")
        employeeNumberString = NSUserDefaults.standardUserDefaults().stringForKey("employeeNumber")
        firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("firstLaunch")
        empNumber = empNumberToUPC.convertEmpNum(employeeNumberString!)
        barCode = generator.generateCode(empNumber!)
        employeeNameLable.text = employeeNameString!.uppercaseString
        barCodeView.image = barCode
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alertHandler(act:UIAlertAction!) {
        NSUserDefaults.standardUserDefaults().setValue(false, forKey: "firstLaunch")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func unwind(seg:UIStoryboardSegue!) {
        
    }


}

