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
    
    func getFormattedDate(format: Date.Format) -> String {
        let dateformat = DateFormatter() // TODO: This should be a static shared DateFormatter....
        dateformat.dateFormat = format.rawValue
        return dateformat.string(from: self)
    }
}
