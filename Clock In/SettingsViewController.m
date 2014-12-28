//
//  SettingsViewController.m
//  Clock In
//
//  Created by Steve Ewell on 12/24/14.
//  Copyright (c) 2014 Steve Ewell. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController()
@property (weak, nonatomic) IBOutlet UILabel *nameCellLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberCellLabel;

@end

@implementation SettingsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSUserDefaults standardUserDefaults]synchronize];
    self.nameCellLabel.text = [[NSUserDefaults standardUserDefaults]stringForKey:@"employeeName"];
    self.numberCellLabel.text = [[NSUserDefaults standardUserDefaults]stringForKey:@"employeeNumber"];
}

-(IBAction)unwindToSettings:(UIStoryboardSegue *)segue {
    
}

@end
