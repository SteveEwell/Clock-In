//
//  ViewController.m
//  Clock In
//
//  Created by Steve Ewell on 12/24/14.
//  Copyright (c) 2014 Steve Ewell. All rights reserved.
//

#import "HomeViewController.h"
#import "BarcodeGenerator.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *empNum = @"478112";
    BarcodeGenerator *barcodeGen = [[BarcodeGenerator alloc]init];
    
    [self.barCodeView setImage:[barcodeGen drawBarcodeAsImage:empNum]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
