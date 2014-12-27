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

@property (weak, nonatomic) IBOutlet UIImageView *barCodeView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) NSString *employeeNameString;
@property (weak, nonatomic) NSString *employeeNumberString;
@property (nonatomic) BOOL firstLaunch;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSUserDefaults standardUserDefaults]synchronize];
    self.employeeNameString = [[NSUserDefaults standardUserDefaults]stringForKey:@"employeeName"];
    self.employeeNumberString = [[NSUserDefaults standardUserDefaults]stringForKey:@"employeeNumber"];
    BarcodeGenerator *barcodeGen = [[BarcodeGenerator alloc]init];
    
    [self.barCodeView setImage:[barcodeGen drawBarcodeAsImage:self.employeeNumberString]];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.firstLaunch = [[NSUserDefaults standardUserDefaults]boolForKey:@"firstLaunch"];
    if (self.firstLaunch == YES) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Disclamer!" message:@"This app is not a replacement for your namebadge. It is intended for your convenience only." delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [alert addButtonWithTitle:@"Ok"];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
