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
    self.editTextField.text = [[NSUserDefaults standardUserDefaults]stringForKey:@"employeeNumber"];
    [self.keyboardToolbar sizeToFit];
    [self.editTextField becomeFirstResponder];
    self.flexBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
}

-(IBAction)doneClicked:(NSObject *)sender {
    
}

@end
