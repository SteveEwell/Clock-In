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
@property (strong, nonatomic) NSUserDefaults *defaults;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.defaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.ewell.TodayExtensionSharingDefaults"];
    [self.defaults synchronize];
    self.nameCellLabel.text = [self.defaults stringForKey:@"employeeName"];
    self.numberCellLabel.text = [self.defaults stringForKey:@"employeeNumber"];
}

-(IBAction)unwindToSettings:(UIStoryboardSegue *)segue {
    
}

@end
