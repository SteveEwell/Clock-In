//
//  ConvertNumberToUPC.swift
//  Clock In
//
//  Created by Steve Ewell on 11/5/14.
//  Copyright (c) 2014 Steve Ewell. All rights reserved.
//

import Foundation

class ConvertToUPC {
    
    func convertStringToUPC(input: String) -> [Int] {
        
        func ConvertStringToCharArray(stringToConvert: String) -> [Character] {
            var i = 6
            var charArray = [Character](count: 12, repeatedValue: "0")
            for character in stringToConvert {
                charArray[i] = character
                ++i
            }
            return charArray
        }
        
        func ConvertCharArray(arrayToConvert: [Character]) -> [String] {
            var i = 0
            var char: Character
            var stringArray = [String](count: 12, repeatedValue: "")
            for ellement in arrayToConvert {
                char = ellement
                stringArray[i].append(char)
                ++i
            }
            return stringArray
        }
        
        func ConvertSringArrayToIntArray(arrayToConvert: [String]) -> [Int] {
            var i = 0
            var intArray = [Int](count: 12, repeatedValue: 0)
            for element in arrayToConvert {
                intArray[i] = element.toInt()!
                ++i
            }
            return intArray
        }
        
        func CalculateUPCValue() -> [Int] {
            var cArray = ConvertStringToCharArray(input)
            var sArray = ConvertCharArray(cArray)
            var iArray = ConvertSringArrayToIntArray(sArray)
            var errorNum = 0
            var evenPosition = 0
            var oddPosition = 0
            var e = 0
            var o = 1
            for var index = 0; index < 6; ++index {
                evenPosition += iArray[e]
                e += 2
                oddPosition += iArray[o]
                o += 2
            }
            evenPosition = evenPosition * 1
            oddPosition = oddPosition * 3
            errorNum = (evenPosition + oddPosition) % 10
            
            iArray.insert(10 - errorNum, atIndex: 12)
            
            return iArray
        }
        
        return CalculateUPCValue()
    }
}