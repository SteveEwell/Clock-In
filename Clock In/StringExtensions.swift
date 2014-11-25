//
//  StringExtensions.swift
//  Clock In
//
//  Created by Steve Ewell on 11/17/14.
//  Copyright (c) 2014 Steve Ewell. All rights reserved.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

import Foundation

extension String {
    func length() -> Int {
        return countElements(self)
    }
    func isNumeric() -> Bool {
        return (self as NSString).rangeOfCharacterFromSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).location == NSNotFound
    }
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    }
    
    func substring(location:Int, length:Int) -> String! {
        return (self as NSString).substringWithRange(NSMakeRange(location, length))
    }
    
    subscript(index: Int) -> String! {
        get {
            return self.substring(index, length: 1)
        }
    }
    
    func location(other: String) -> Int {
        return (self as NSString).rangeOfString(other).location
    }
}