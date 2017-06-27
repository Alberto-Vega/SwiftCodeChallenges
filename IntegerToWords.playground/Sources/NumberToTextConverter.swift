import Foundation

public class NumberToTextConverter {
    public init() {
        
    }
    let ones = [0 : "zero",
                1 : "one",
                2 : "two",
                3 : "three",
                4 : "four",
                5 : "five",
                6 : "Six",
                7 : "seven",
                8 : "eigth",
                9 : "nine"]
    let elevenToNineteen = [11 : "eleven",
                            12 : "twelve",
                            13 : "thirteen",
                            14 : "fourteen",
                            15 : "fifteen",
                            16 : "sixteen",
                            17 : "seventeen",
                            18 : "eighteen",
                            19 : "nineteen"]
    let tens = [10: "ten",
                20: "twenty",
                30: "thirty",
                40: "forty",
                50: "fifty",
                60: "sixty",
                70: "seventy",
                80: "eighty",
                90: "ninety"]
    
    func textFromSingleDigit(number: Int) -> String? {
        var result: String?
            result = ones[number] ?? "This number is not a single digit"
        return result ?? nil
    }
    
    func textFromTwoDigit(number: Int) -> String? {
        var result: String?
        switch true {
        case number < 20:
            if number > 10 {
                result = elevenToNineteen[number] ?? nil
            }
            else if number == 10 {
                result = tens[number]
            }
            else {
                result = ones[number] ?? nil
            }
            
        case number >= 20 && number <= 99 :
            let onesDigit = number % 10
            if onesDigit != 0 {
                result = "\(tens[(number/10) * 10] ?? "nil") \(ones[onesDigit] ?? " ")"
            } else {
                result = "\(tens[(number/10) * 10] ?? "nil")"
            }
        default:
            result = "Failed to map number to Textual Representation"
        }
        return result ?? nil
    }
    
    func textFromThreeDigit(number: Int) -> String? {
        var result: String?
        let hundredUnits = number/100
        let lastTwoDigits = number % 100
        if lastTwoDigits == 0 {
            result = "\(textFromSingleDigit(number: hundredUnits) ?? "") hundred"
        } else {
            result = "\(textFromSingleDigit(number: hundredUnits) ?? "") hundred \(textFromTwoDigit(number: lastTwoDigits) ?? "")"
        }
        return result ?? nil
    }
    
    func textFromFourDigit(number: Int) -> String? {
        var result: String?
        let thousandUnits = number/1000
        let lastThreeDigits = number % 1000
        if lastThreeDigits == 0 {
            result = "\(textFromSingleDigit(number: thousandUnits) ?? "") thousand"
        } else {
            result = "\(textFromSingleDigit(number: thousandUnits) ?? "") thousand \(textFromThreeDigit(number: lastThreeDigits) ?? "")"
        }
        return result ?? nil
    }
    
    func textFromFiveDigit(number: Int) -> String? {
        var result: String?
        let thousandUnits = number/1000
        let lastThreeDigits = number % 1000
        if lastThreeDigits == 0 {
            result = "\(textFromTwoDigit(number: thousandUnits) ?? "") thousand"
        } else {
            result = "\(textFromTwoDigit(number: thousandUnits) ?? "") thousand \(textFromThreeDigit(number: lastThreeDigits) ?? "")"
        }
        return result ?? nil
    }
    
    public func textualRepresentation(ofInt: Int) -> String? {
        var result: String?
        switch true {
        case ofInt < 10 :
            result = textFromSingleDigit(number: ofInt)
        case ofInt >= 10 && ofInt <= 99:
            result = textFromTwoDigit(number: ofInt)
        case ofInt >= 100 && ofInt <= 999:
            result = textFromThreeDigit(number: ofInt)
        case ofInt >= 1000 && ofInt <= 9000:
            result = textFromFourDigit(number: ofInt)
        case ofInt >= 10_000 && ofInt <= 99_999:
            result = textFromFiveDigit(number: ofInt)
        default:
            result = "Failed to map number to Textual Representation"
        }
        return result ?? nil
    }
}
