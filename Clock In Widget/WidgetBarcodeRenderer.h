//
//  WidgetBarcodeRenderer.h
//  Clock In
//
//  Created by Steve Ewell on 3/22/15.
//  Copyright (c) 2015 Steve Ewell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WidgetBarcodeRenderer : NSObject

-(UIImage *)drawBarcodeAsImage:(NSString *)input;

@end
