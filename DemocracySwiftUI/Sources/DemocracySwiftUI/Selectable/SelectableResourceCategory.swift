//
//  SelectableResourceCategory.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/30/24.
//

import Foundation
import SharedResourcesClientAndServer
import SharedSwiftUI

public struct SelectableResourceCategory: Selectable {
    public let resourceCategory: ResourceCategory
    
    public init(_ resourceCategory: ResourceCategory) {
        self.resourceCategory = resourceCategory
    }

    // Provide all cases of the wrapper type
    public static var allCases: [SelectableResourceCategory] {
        ResourceCategory.allCases.map { SelectableResourceCategory($0) }
    }

    public static let metaTitle: String = "Resource Type"
    public static let metaImage: SystemImage = .booksVerticalFill

    public var title: String {
        resourceCategory.id
    }

    public var subtitle: String? {
        nil
    }

    public var image: SystemImage? {
        switch resourceCategory {
        case .book:
            return .bookClosed
        case .website:
            return .laptopComputer
        case .magazine:
            return .book
        case .movie:
            return .movieClapper
        }
    }

    public var id: String {
        title
    }
}
