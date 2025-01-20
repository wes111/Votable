//
//  Date+Extension.swift
//  SharedSwift
//
//  Created by Wesley Luntsford on 1/1/25.
//

import Foundation

public extension Date {
    enum Format: String {
        case ddMMMyyyy = "dd MMM yyyy"
    }
    
    private static let sharedDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        return formatter
    }()
    
    func getFormattedDate(format: Date.Format) -> String {
        Date.sharedDateFormatter.dateFormat = format.rawValue
        return Date.sharedDateFormatter.string(from: self)
    }
}
