//
//  TodayViewController.m
//  Clock In Widget
//
//  Created by Steve Ewell on 3/21/15.
//  Copyright (c) 2015 Steve Ewell. All rights reserved.
//

#import <NotificationCenter/NotificationCenter.h>
#import <QuartzCore/QuartzCore.h>
#import "TodayViewController.h"
#import "WidgetBarcodeRenderer.h"


@interface TodayViewController () <NCWidgetProviding>

@property (weak, nonatomic) IBOutlet UIImageView *barcode;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WidgetBarcodeRenderer *barcodeGen = [[WidgetBarcodeRenderer alloc]init];
    NSUserDefaults *defaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.ewell.TodayExtensionSharingDefaults"];
    [self.barcode setImage:[barcodeGen drawBarcodeAsImage:[defaults stringForKey:@"employeeNumber"]]];
    CALayer *imageLayer = [self.barcode layer];
    [imageLayer setMasksToBounds:YES];
    [imageLayer setCornerRadius:5];
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

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}

@end
