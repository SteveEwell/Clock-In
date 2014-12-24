//
//  BarcodeGenerator.m
//  Clock In
//
//  Created by Steve Ewell on 12/20/14.
//  Copyright (c) 2014 Steve Ewell. All rights reserved.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//
//  The MIT License (MIT)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "BarcodeGenerator.h"

@interface BarcodeGenerator()

-(NSString *)convertEmpNumToUPC:(NSString *)input;
-(NSString *)convertEmpNumToBinaryEncoding:(NSString *)input;

@end

@implementation BarcodeGenerator


-(NSString *)convertEmpNumToUPC:(NSString *)input {
    
    NSMutableString *output = [NSMutableString stringWithCapacity:13];
    NSMutableArray *empUPC = [NSMutableArray array];
    NSString *zero = @"0";
    NSString *subString;
    int evenSum = 0;
    int oddSum = 0;
    int checkDigit = 0;
    
    for (int i = 0; i<12; i++) {
        if (i < 12 - input.length) {
            [empUPC insertObject:zero atIndex:i];
        } else {
            subString = [input substringWithRange:NSMakeRange(i - input.length, 1)];
            [empUPC insertObject:subString atIndex:i];
        }
    }
    
    for (int i = 0; i<12; i++) {
        [output appendString:[empUPC objectAtIndexedSubscript:i]];
    }
    
    for (int i = 0; i < 12; i++) {
        int digit = [[output substringWithRange:NSMakeRange(i, 1)] intValue];
        if (i % 2 == (output.length == 12 ? 0 : 1)) {
            evenSum += digit;
        } else {
            oddSum += digit;
        }
    }
    checkDigit = (10 - (evenSum + (oddSum * 3)) % 10);
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
    
    NSString *upc;
    NSString *binary;
    upc = [self convertEmpNumToUPC:input];
    binary = [self convertEmpNumToBinaryEncoding:upc];
    
    
    if (binary.length <= 0) {
        return nil;
    }
    
    CGSize size = CGSizeMake(230, 115);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetShouldAntialias(context, false);
    
    [[UIColor whiteColor] setFill];
    [[UIColor blackColor] setStroke];
    
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    CGContextSetLineWidth(context, 2);
    
    int padding = 10;
    for (int i = 0; i < binary.length; i++) {
        NSString *character = [binary substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"1"]) {
            CGContextMoveToPoint(context, padding * 2, 2);
            CGContextAddLineToPoint(context, padding * 2, size.height - 2);
            
        }
        padding++;
    }
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIImage *barcode = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return barcode;
}



@end
