// Playground - noun: a place where people can play

import UIKit

class EmpNumToUPCA {
    
    func convertEmpNum(input: String) -> String {
        var upca: [Int] = self.stringToUPCA(input)
        var cDigit:Int = self.checkDigit(upca)
        upca.insert(cDigit, atIndex: 11)
        var upcaString = ""
        for number in upca {
            upcaString += "\(number)"
        }
        
        return upcaString
    }
    
    private func stringToUPCA (input: String) -> [Int] {
        var i = 11 - input.length()
        var j = 0
        var char:Character
        var stringArray = [String](count: 11, repeatedValue: "0")
        var intArray = [Int](count: stringArray.count, repeatedValue: 0)
        // Converts input into [stringArray]
        for elementString in input {
            char = elementString
            stringArray[i].append(char)
            i++
        }
        // Converts [stringArray] to [intArray]
        for elementInt in stringArray {
            intArray[j] = elementInt.toInt()!
            j++
        }
        
        return intArray
    }
    
    private func checkDigit(input: [Int]) -> Int {
        var upca = input
        var evenSum = 0
        var oddSum = 0
        var checkDigit = 0
        
        for i in 0..<upca.count {
            let digit = upca[i]
            
            // Checks if the result of % 2 is 0 or 1 
            //result of 0 = evenSum, result of 1 = oddSum.
            if i % 2 == (input.count == 12 ? 0 : 1) {
                evenSum += digit
            } else {
                oddSum += digit
            }
        }
        checkDigit = (10 - (evenSum + (oddSum * 3)) % 10)
        
        
        return checkDigit
    }
    
}

extension String {
    func length() -> Int {
        return countElements(self)
    }
    func isNumeric() -> Bool {
        return (self as NSString).rangeOfCharacterFromSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).location == NSNotFound
    }
}


var hahanumber = EmpNumToUPCA().convertEmpNum("478112")


