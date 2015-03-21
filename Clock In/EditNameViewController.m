//
//  EditNameViewController.m
//  Clock In
//
//  Created by Steve Ewell on 12/24/14.
//  Copyright (c) 2014 Steve Ewell. All rights reserved.
//

#import "EditNameViewController.h"

@interface EditNameViewController()

@property (weak, nonatomic) IBOutlet UITextField *editTextField;
@property (strong, nonatomic) NSString *employeeName;
@property (strong, nonatomic) NSUserDefaults *defaults;
@end

@implementation EditNameViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.defaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.ewell.TodayExtensionSharingDefaults"];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.employeeName = [[NSString alloc]init];
    self.editTextField.text = [self.defaults stringForKey:@"employeeName"];
    [self.editTextField becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.employeeName = self.editTextField.text;
    if (self.employeeName.length > 26 || self.employeeName.length == 0) {
        [self.defaults synchronize];
    } else {
        [self.defaults setValue:self.employeeName forKey:@"employeeName"];
        [self.defaults synchronize];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.employeeName = self.editTextField.text;
    if (self.employeeName.length > 26 || self.employeeName.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Name is too long or too short!" message:@"Entered names must be between 1 and 26 characters long." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    } else {
        [self.defaults setValue:self.employeeName forKey:@"employeeName"];
        [self.defaults synchronize];
        [self performSegueWithIdentifier:@"toSettings" sender: self];
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.defaults setValue:@"Name" forKey:@"employeeName"];
        [self.defaults synchronize];
        [self.editTextField becomeFirstResponder];
    }
}

@end
