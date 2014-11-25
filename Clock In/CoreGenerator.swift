//
//  CoreGenerator.swift
//  Clock In
//
//  Created by Steve Ewell on 11/17/14.
//  Copyright (c) 2014 Steve Ewell. All rights reserved.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CoreImage


class CoreGenerator {
    
    var length = 13
    
    // 'O' for odd and 'E' for even
    let lefthandParities = [
        "OOOOOO",
        "OOEOEE",
        "OOEEOE",
        "OOEEEO",
        "OEOOEE",
        "OEEOOE",
        "OEEEOO",
        "OEOEOE",
        "OEOEEO",
        "OEEOEO"
    ]
    // 'R' for right-hand
    let parityEncodingTable = [
        ["O" : "0001101", "E" : "0100111", "R" : "1110010"],
        ["O" : "0011001", "E" : "0110011", "R" : "1100110"],
        ["O" : "0010011", "E" : "0011011", "R" : "1101100"],
        ["O" : "0111101", "E" : "0100001", "R" : "1000010"],
        ["O" : "0100011", "E" : "0011101", "R" : "1011100"],
        ["O" : "0110001", "E" : "0111001", "R" : "1001110"],
        ["O" : "0101111", "E" : "0000101", "R" : "1010000"],
        ["O" : "0111011", "E" : "0010001", "R" : "1000100"],
        ["O" : "0110111", "E" : "0001001", "R" : "1001000"],
        ["O" : "0001011", "E" : "0010111", "R" : "1110100"]
    ]
    
    
    // Checks if UPC String is 13 digits long and contains numbers
    func isValidUPC(input: String) -> Bool {
        let length = input.length()
        if length == 13 {
            for i in 0..<length {
                let value = input[i]
                if !value.isNumeric() {
                    return false
                }
            }
            return true
        }
        return false
    }
    
    func initiator() -> String {
        return "101"
    }
    
    func centerGuardPattern() -> String {
        return "01010"
    }
    
    func terminator() -> String {
        return "101"
    }
    
    func barcode(contents:String) -> String {
        var lefthandParity = "OOOO"
        var newContents = contents
        if self.length == 13 {
            lefthandParity = self.lefthandParities[contents[0].toInt()!]
            newContents = contents.substring(1, length: contents.length() - 1)
        }
        
        var barcode = ""
        for i in 0..<newContents.length() {
            let digit = newContents[i].toInt()!
            if i < lefthandParity.length() {
                barcode += self.parityEncodingTable[digit][lefthandParity[i]]!
                if i == lefthandParity.length() - 1 {
                    barcode += self.centerGuardPattern()
                }
            } else {
                barcode += self.parityEncodingTable[digit]["R"]!
            }
        }
        return barcode
    }
    
    
    // Composer for combining barcode initiator, contents, terminator together.
    func completeBarcode(barcode:String) -> String {
        return self.initiator() + barcode + self.terminator()
    }
    
    // Drawer for completed barcode.
    func drawCompleteBarcode(completeBarcode:String) -> UIImage? {
        let length:Int = completeBarcode.length()
        if length <= 0 {
            return nil
        }
        
        // Values taken from CIImage generated AVMetadataObjectTypePDF417Code type image
        // Top spacing          = 1.5
        // Bottom spacing       = 2
        // Left & right spacing = 4
        // Height               = 4
        let width = (length * 2) + 8
        let size = CGSizeMake(CGFloat(width), 120)
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetShouldAntialias(context, true)
        
        UIColor.whiteColor().setFill()
        UIColor.blackColor().setStroke()
        
        CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height))
        CGContextSetLineWidth(context, 2)
        
        for i in 0..<length {
            let character = completeBarcode[i]
            if character == "1" {
                let x = i + (2 + 1)
                CGContextMoveToPoint(context, CGFloat(x) * 2, 1.5)
                CGContextAddLineToPoint(context, CGFloat(x) * 2, size.height - 2)
            }
        }
        CGContextDrawPath(context, kCGPathFillStroke)
        let barcode = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return barcode
    }
    
    func generateCode(contents:String) -> UIImage? {
        if self.isValidUPC(contents) {
            return self.drawCompleteBarcode(self.completeBarcode(self.barcode(contents)))
        }
        return nil
    }
    
}