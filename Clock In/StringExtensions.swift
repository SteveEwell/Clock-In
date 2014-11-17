//
//  StringExtensions.swift
//  Clock In
//
//  Created by Steve Ewell on 11/17/14.
//  Copyright (c) 2014 Steve Ewell. All rights reserved.
//

import Foundation

extension String {
    func length() -> Int {
        return countElements(self)
    }
    func isNumeric() -> Bool {
        return (self as NSString).rangeOfCharacterFromSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).location == NSNotFound
    }
}