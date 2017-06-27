//: Playground - noun: a place where people can play

import UIKit

let ones = [0 : "zero ",
            1 : "one ",
            2 : "two ",
            3 : "three ",
            4 : "four ",
            5 : "five ",
            6 : "Six ",
            7 : "seven ",
            8 : "eigth ",
            9 : "nine ",
            11 : "eleven ",
            12 : "twelve ",
            13 : "thirteen ",
            14 : "fourteen ",
            15 : "fifteen ",
            16 : "sixteen ",
            17 : "seventeen ",
            18 : "eighteen ",
            19 : "nineteen "]

let tens = [10: "ten ",
            20: "twenty ",
            30: "thirty ",
            40: "forty ",
            50: "fifty ",
            60: "sixty ",
            70: "seventy ",
            80: "eighty ",
            90: "ninety "]

func wordsFrom(number: Int) -> String? {
    var result = ""
    switch true {
    case number < 20:
        guard let ones = ones[number] else { break }
            result += ones
        
    case number >= 20 && number <= 99 :
        let tensDigit = number/10
        let tensNumber = (tensDigit) * 10
        let onesDigit = number % 10
        if onesDigit != 0 {
            result += "\(tens[tensNumber] ?? "nil") \(ones[onesDigit] ?? " ")"
        } else {
            result += "\(tens[tensNumber] ?? "nil")"
        }
    default:
        result = "Failed to map number to Textual Representation"
    }
    return result
}

public func convertToWords(number: Int) -> String? {
    
    var results = ""
    let hundredsThousandUnits = (number / 100000) % 100
    let thousandUnits = (number / 1000) % 100
    let hundredsUnits = (number / 100) % 10
    let tens = (number % 100)
    
    if hundredsThousandUnits != 0 {
        if let hundredsThousands = wordsFrom(number: hundredsThousandUnits) {
            results += hundredsThousands + "hundred "
        }
    }
    if thousandUnits != 0 {
        if let thousands = wordsFrom(number: thousandUnits) {
            results += thousands + "thousand "
        }
    }
    
    if hundredsUnits != 0 {
        if let hundreds = wordsFrom(number: hundredsUnits) {
            results += " " + hundreds + "hundred "
        }
    }
    
    if tens != 0 {
        if let tens = wordsFrom(number: tens) {
            results += tens
        }
    }
    return results
}

//func toWords(number: Int) -> String {
//    return textualRepresentation(ofInt: number) ?? "Error"
//}


Assertion(actual: wordsFrom(number: 19)!, expected: "nineteen")
Assertion(actual: wordsFrom(number: 1)!, expected: "one ")
Assertion(actual: wordsFrom(number: 31)!, expected: "thirty one ")
Assertion(actual: wordsFrom(number: 30)!, expected: "thirty")
Assertion(actual: convertToWords(number: 120)!, expected: "one hundred twenty")
Assertion(actual: convertToWords(number: 120)!, expected: "one hundred twenty")
Assertion(actual: convertToWords(number: 1100)!, expected: "one thousand one hundred")
Assertion(actual: convertToWords(number: 120000)!, expected: "one hundred twenty thousand")

////Assertion(actual: toWords(number: nil), expected: nil)
//Assertion(actual: toWords(number: 51), expected: "fifty one")
//Assertion(actual: toWords(number: 152), expected: "one hundred fifty two")
//Assertion(actual: toWords(number: 1100), expected: "one thousand one hundred")
//Assertion(actual: toWords(number: 21220), expected: "twenty one thousand two hundred twenty")
//Assertion(actual: toWords(number: 100000), expected: "one hundred thousand")
//

