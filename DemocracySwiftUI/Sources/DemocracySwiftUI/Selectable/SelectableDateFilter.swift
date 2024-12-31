//
//  SelectableDateFilter.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/30/24.
//

import SharedResourcesClientAndServer
import SharedSwiftUI

public struct SelectableDateFilter: Selectable {
    public let dateFilter: DateFilter

    public static var allCases: [SelectableDateFilter] {
        DateFilter.allCases.map { SelectableDateFilter($0) }
    }

    public static let metaTitle: String = "Date Filter"
    public static let metaImage: SystemImage = .calendar

    public var title: String {
        dateFilter.id
    }

    public var subtitle: String? {
        nil
    }

    public var image: SystemImage? {
        nil
    }

    public var id: String {
        title
    }

    // Initialize with the original type
    public init(_ dateFilter: DateFilter) {
        self.dateFilter = dateFilter
    }
}
