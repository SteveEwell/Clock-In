//
//  WatchBarcodeGenerator.h
//  Clock In
//
//  Created by Steve Ewell on 6/23/15.
//  Copyright (c) 2015 Steve Ewell. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface WatchBarcodeGenerator : NSObject

-(UIImage *)drawBarcodeAsImage:(NSString *)input;

@end
