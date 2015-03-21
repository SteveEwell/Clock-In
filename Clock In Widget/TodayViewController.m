//
//  TodayViewController.m
//  Clock In Widget
//
//  Created by Steve Ewell on 3/21/15.
//  Copyright (c) 2015 Steve Ewell. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>


@interface TodayViewController () <NCWidgetProviding>

@property (strong, nonatomic) NSString *employeeNameString;
@property (strong, nonatomic) NSString *employeeNumberString;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.ewell.TodayExtensionSharingDefaults"];
    self.employeeNameString = [defaults stringForKey:@"employeeName"];
    self.employeeNumberString = [defaults stringForKey:@"employeeNumber"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    completionHandler(NCUpdateResultNewData);
}

@end
