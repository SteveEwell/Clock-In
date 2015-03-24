//
//  SettingsNavigationController.m
//  Clock In
//
//  Created by Steve Ewell on 3/24/15.
//  Copyright (c) 2015 Steve Ewell. All rights reserved.
//

#import "SettingsNavigationController.h"

@interface SettingsNavigationController ()

@end

@implementation SettingsNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

-(IBAction)doDismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
