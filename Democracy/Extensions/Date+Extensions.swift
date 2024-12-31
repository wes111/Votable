//
//  Date+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/3/23.
//

import Foundation

extension Date {
    
    enum Format: String {
        case ddMMMyyyy = "dd MMM yyyy"
    }
    
    var yearInt: Int {
        return Calendar.current.dateComponents([.year], from: self).year!
    }
    
    func getFormattedDate(format: Date.Format) -> String {
        let dateformat = DateFormatter() // TODO: This should be a static shared DateFormatter....
        dateformat.dateFormat = format.rawValue
        return dateformat.string(from: self)
    }
    
    /// Returns yesterday. A positive offset can be provided to specify 
    /// how many days previous, where 0 is today.
    static func previousDay(offset: Int = 1) -> Date {
        Calendar.current.date(byAdding: .day, value: -offset, to: Date())!
    }
    
    func isToday() -> Bool {
        Calendar.current.isDateInToday(self)
    }
    
    func isYesterday() -> Bool {
        Calendar.current.isDateInYesterday(self)
    }
}
