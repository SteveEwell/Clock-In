//
//  InterfaceController.m
//  Clock In WatchKit Extension
//
//  Created by Steve Ewell on 6/20/15.
//  Copyright (c) 2015 Steve Ewell. All rights reserved.
//

#import "InterfaceController.h"
#import "WatchBarcodeGenerator.h"


@interface InterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceImage *watchBarcode;
@property (strong, nonatomic) NSUserDefaults *defaults;
@property (strong, nonatomic) WatchBarcodeGenerator *barcodeGen;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    self.defaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.ewell.TodayExtensionSharingDefaults"];
    self.barcodeGen = [[WatchBarcodeGenerator alloc]init];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    [self.watchBarcode setImage:[self.barcodeGen drawBarcodeAsImage:[self.defaults stringForKey:@"employeeNumber"]]];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



