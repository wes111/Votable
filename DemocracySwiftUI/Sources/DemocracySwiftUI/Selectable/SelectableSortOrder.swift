//
//  SelectableSortOrder.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/30/24.
//

import Foundation
import SharedResourcesClientAndServer
import SharedSwiftUI

public struct SelectableSortOrderOption: Selectable {
    public let sortOrderOption: SortOrderOption

    public static var allCases: [SelectableSortOrderOption] {
        SortOrderOption.allCases.map { SelectableSortOrderOption($0) }
    }

    public static let metaTitle: String = "Sort Order"
    public static let metaImage: SystemImage = .arrowUpArrowDown

    public var title: String {
        sortOrderOption.id
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

    public init(_ sortOrderOption: SortOrderOption) {
        self.sortOrderOption = sortOrderOption
    }
}
