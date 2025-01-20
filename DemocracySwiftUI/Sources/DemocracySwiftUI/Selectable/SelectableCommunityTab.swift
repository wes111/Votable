//
//  SelectableCommunityTab.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/30/24.
//

import Foundation
import SharedResourcesClientAndServer
import SharedSwiftUI

public struct SelectableCommunityTab: Selectable {
    public let communityTab: CommunityTab

    public static var allCases: [SelectableCommunityTab] {
        CommunityTab.allCases.map { SelectableCommunityTab($0) }
    }

    public static let metaTitle: String = "Community Tab"
    public static let metaImage: SystemImage = .book

    public var title: String {
        communityTab.id
    }

    public var subtitle: String? {
        nil
    }

    public var image: SystemImage? {
        switch communityTab {
        case .feed:
            return .newspaperFill
        case .info:
            return .infoCircle
        case .archive:
            return .booksVerticalFill
        case .vote:
            return .checkmarkCircleFill
        case .manage:
            return .buildingColumns
        }
    }

    public var id: String {
        title
    }

    // Initialize with the original type
    public init(_ communityTab: CommunityTab) {
        self.communityTab = communityTab
    }
}
