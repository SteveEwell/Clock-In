//
//  ViewController.m
//  Clock In
//
//  Created by Steve Ewell on 12/24/14.
//  Copyright (c) 2014 Steve Ewell. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "HomeViewController.h"
#import "BarcodeGenerator.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *barCodeView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) NSString *employeeNameString;
@property (strong, nonatomic) NSString *employeeNumberString;
@property (strong, nonatomic) NSUserDefaults *defaults;
@property (nonatomic) BOOL firstLaunch;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.ewell.TodayExtensionSharingDefaults"];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.defaults synchronize];
    self.employeeNameString = [[NSString alloc]init];
    self.employeeNumberString = [[NSString alloc]init];
    self.employeeNameString = [self.defaults stringForKey:@"employeeName"];
    self.employeeNumberString = [self.defaults stringForKey:@"employeeNumber"];
    BarcodeGenerator *barcodeGen = [[BarcodeGenerator alloc]init];
    self.nameLabel.text = self.employeeNameString.uppercaseString;
    [self.barCodeView setImage:[barcodeGen drawBarcodeAsImage:self.employeeNumberString]];
    CALayer *imageLayer = [self.barCodeView layer];
    [imageLayer setMasksToBounds:YES];
    [imageLayer setCornerRadius:5];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.firstLaunch = [self.defaults boolForKey:@"firstLaunch"];
    if (self.firstLaunch == YES) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Disclamer!" message:@"This app is not a replacement for your namebadge. It is intended for your convenience only." delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [alert addButtonWithTitle:@"Ok"];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.defaults setBool:NO forKey:@"firstLaunch"];
        [self.defaults synchronize];
    }
}

-(IBAction)unwindToHome:(UIStoryboardSegue *)segue {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
