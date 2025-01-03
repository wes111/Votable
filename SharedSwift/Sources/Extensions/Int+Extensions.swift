//
//  Int+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/13/24.
//

import Foundation

public extension Int {
    @MainActor
    private static let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()

    @MainActor
    var delimiter: String {
        return Int.numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}