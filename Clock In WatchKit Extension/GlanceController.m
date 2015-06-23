//
//  GlanceController.m
//  Clock In WatchKit Extension
//
//  Created by Steve Ewell on 6/20/15.
//  Copyright (c) 2015 Steve Ewell. All rights reserved.
//

#import "GlanceController.h"


@interface GlanceController()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *employeeNameLabel;
@property (strong, nonatomic) NSUserDefaults *defaults;

@end


@implementation GlanceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
     self.defaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.ewell.TodayExtensionSharingDefaults"];
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [self.employeeNameLabel setText:[self.defaults stringForKey:@"employeeName"]];
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



