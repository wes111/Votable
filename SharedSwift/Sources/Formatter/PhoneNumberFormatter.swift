//
//  PhoneNumberFormatter.swift
//  SharedResourcesClientAndServer
//
//  Created by Wesley Luntsford on 11/16/24.
//

import Foundation

// MARK: - Phone Formatter
public enum PhoneFormatter {
    // https://stackoverflow.com/questions/32364055/formatting-phone-number-in-swift
    // mask example: `+X (XXX) XXX-XXXX`
    public static func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for char in mask where index < numbers.endIndex {
            if char == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(char) // just append a mask character
            }
        }
        return result
    }
}
