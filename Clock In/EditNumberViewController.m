//
//  EditNumberViewController.m
//  Clock In
//
//  Created by Steve Ewell on 12/24/14.
//  Copyright (c) 2014 Steve Ewell. All rights reserved.
//

#import "EditNumberViewController.h"

@interface EditNumberViewController()

@property (weak, nonatomic) IBOutlet UITextField *editTextField;
@property (strong, nonatomic) NSString *employeeNumber;
@property (strong, nonatomic) UIToolbar *keyboardToolbar;
@property (strong, nonatomic) UIBarButtonItem *flexBarButton;
@property (strong, nonatomic) UIBarButtonItem *doneButton;

@end

@implementation EditNumberViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.ewell.TodayExtensionSharingDefaults"];
    self.editTextField.text = [defaults stringForKey:@"employeeNumber"];
    self.keyboardToolbar = [[UIToolbar alloc]init];
    [self.keyboardToolbar sizeToFit];
    [self.editTextField becomeFirstResponder];
    self.flexBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    self.keyboardToolbar.items = [[NSArray alloc]initWithObjects:self.flexBarButton, self.doneButton, nil];
    self.editTextField.inputAccessoryView = self.keyboardToolbar;
    [self.editTextField becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSUserDefaults *defaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.ewell.TodayExtensionSharingDefaults"];
    self.employeeNumber = self.editTextField.text;
    if (self.employeeNumber.length > 12 || self.employeeNumber.length == 0) {
        [defaults synchronize];
    } else {
        [defaults setValue:self.employeeNumber forKey:@"employeeNumber"];
        [defaults synchronize];
    }
}

-(IBAction)doneClicked:(NSObject *)sender {
    NSUserDefaults *defaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.ewell.TodayExtensionSharingDefaults"];
    self.employeeNumber = self.editTextField.text;
    if (self.employeeNumber.length > 12 || self.employeeNumber.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Number out of range!" message:@"Enter a number between 1 and 999999." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    } else {
        [defaults setValue:self.employeeNumber forKey:@"employeeNumber"];
        [defaults synchronize];
        [self performSegueWithIdentifier:@"toSettings" sender: self];
    }
    [self.view endEditing:YES];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSUserDefaults *defaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.ewell.TodayExtensionSharingDefaults"];
        [defaults setValue:@"123456" forKey:@"employeeNumber"];
        [defaults synchronize];
        [self.editTextField becomeFirstResponder];
    }
}

@end
