//
//  WatchBarcodeGenerator.m
//  Clock In
//
//  Created by Steve Ewell on 6/23/15.
//  Copyright (c) 2015 Steve Ewell. All rights reserved.
//

#import "WatchBarcodeGenerator.h"

@interface WatchBarcodeGenerator()

-(BOOL)isValidUPC:(NSString *)input;
-(NSString *)convertEmpNumToUPC:(NSString *)input;
-(NSString *)convertEmpNumToBinaryEncoding:(NSString *)input;

@end

@implementation WatchBarcodeGenerator

-(BOOL)isValidUPC:(NSString *)input {
    int sumOfString = 0;
    for (int i=0; i < input.length; i++) {
        int digit = [[input substringWithRange:NSMakeRange(i, 1)] intValue];
        sumOfString += digit;
    }
    if (sumOfString == 0) {
        return NO;
    } else {
        return YES;
    }
}

-(NSString *)convertEmpNumToUPC:(NSString *)input {
    
    NSMutableString *output = [NSMutableString stringWithCapacity:13];
    NSString *zero = @"0";
    int evenSum = 0;
    int oddSum = 0;
    int checkDigit = 0;
    
    // Prevents crashing if all zero value is entered.
    // All zero value causes array to exceed bounds.
    if ([self isValidUPC:input] == NO) {
        return nil;
    }
    
    for (int i = 0; i<12 - input.length; i++) {
        [output appendString:zero];
    }
    
    [output appendString:input];
    
    for (int i = 0; i < 12; i++) {
        int digit = [[output substringWithRange:NSMakeRange(i, 1)] intValue];
        if (i % 2 == (output.length == 12 ? 0 : 1)) {
            evenSum += digit;
        } else {
            oddSum += digit;
        }
    }
    checkDigit = (10 - (evenSum + (oddSum * 3)) % 10);
    
    if (checkDigit >=10) {
        checkDigit = 0;
    }
    
    [output appendString:[NSString stringWithFormat:@"%i",checkDigit]];
    
    return output;
}

-(NSString *)convertEmpNumToBinaryEncoding:(NSString *)input {
    
    NSArray *lefthandParities = @[
                                  @"OOOOOO",
                                  @"OOEOEE",
                                  @"OOEEOE",
                                  @"OOEEEO",
                                  @"OEOOEE",
                                  @"OEEOOE",
                                  @"OEEEOO",
                                  @"OEOEOE",
                                  @"OEOEEO",
                                  @"OEEOEO"
                                  ];
    
    NSArray *parityEncodingTable = @[
                                     @{@"O" : @"0001101", @"E" : @"0100111", @"R" : @"1110010"},
                                     @{@"O" : @"0011001", @"E" : @"0110011", @"R" : @"1100110"},
                                     @{@"O" : @"0010011", @"E" : @"0011011", @"R" : @"1101100"},
                                     @{@"O" : @"0111101", @"E" : @"0100001", @"R" : @"1000010"},
                                     @{@"O" : @"0100011", @"E" : @"0011101", @"R" : @"1011100"},
                                     @{@"O" : @"0110001", @"E" : @"0111001", @"R" : @"1001110"},
                                     @{@"O" : @"0101111", @"E" : @"0000101", @"R" : @"1010000"},
                                     @{@"O" : @"0111011", @"E" : @"0010001", @"R" : @"1000100"},
                                     @{@"O" : @"0110111", @"E" : @"0001001", @"R" : @"1001000"},
                                     @{@"O" : @"0001011", @"E" : @"0010111", @"R" : @"1110100"}
                                     ];
    
    NSString *lefthandParity = @"OOOO";
    
    if (input.length == 13) {
        lefthandParity = lefthandParities[[[input substringToIndex:1] intValue]];
        input = [input substringFromIndex:1];
    }
    
    NSMutableString *barcode = [[NSMutableString alloc] initWithString:@"101"];
    for (int i = 0; i < input.length; i++) {
        int digit = [[input substringWithRange:NSMakeRange(i, 1)] intValue];
        if (i < lefthandParity.length) {
            [barcode appendString:[NSString stringWithFormat: @"%@", parityEncodingTable[digit][[lefthandParity substringWithRange: NSMakeRange(i, 1)]]]];
            if (i == lefthandParity.length - 1) {
                [barcode appendString:[NSString stringWithFormat:@"01010"]];
            }
        } else {
            [barcode appendString:[NSString stringWithFormat:@"%@", parityEncodingTable[digit][@"R"]]];
        }
    }
    [barcode appendString:[NSString stringWithFormat:@"101"]];
    return [NSString stringWithString:barcode];
}

-(UIImage *)drawBarcodeAsImage:(NSString *)input {
    
    if ([self isValidUPC:input] == NO) {
        return nil;
    }
    
    NSString *upc;
    NSString *binary;
    upc = [self convertEmpNumToUPC:input];
    binary = [self convertEmpNumToBinaryEncoding:upc];
    
    
    if (binary.length <= 0) {
        return nil;
    }
    // 415 230
    CGSize size = CGSizeMake(136, 145);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetShouldAntialias(context, false);
    
    [[UIColor whiteColor] setFill];
    
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    CGContextSetLineWidth(context, 1);
    [[UIColor blackColor] setStroke];
    
    float padding = 5;
    for (int i = 0; i < binary.length; i++) {
        NSString *character = [binary substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"1"]) {
            CGContextMoveToPoint(context, 5, padding * 1.4 );
            CGContextAddLineToPoint(context, size.width - 5, padding * 1.4);
            
        }
        padding++;
    }
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIImage *barcode = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return barcode;
}

@end

