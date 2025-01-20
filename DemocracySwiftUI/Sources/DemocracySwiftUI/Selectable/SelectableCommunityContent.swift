//
//  SelectableCommunityContent.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/30/24.
//

import Foundation
import SharedResourcesClientAndServer
import SharedSwiftUI

public struct SelectableCommunityContent: Selectable {
    public let communityContent: CommunityContent

    public static var allCases: [SelectableCommunityContent] {
        CommunityContent.allCases.map { SelectableCommunityContent($0) }
    }

    public static let metaTitle: String = "Content Type"
    public static let metaImage: SystemImage = .figureAndChildHoldingHands

    public var title: String {
        communityContent.id
    }

    public var subtitle: String? {
        switch communityContent {
        case .familyFriendly:
            return "Adult content is not allowed within the community."
        case .adultContent:
            return "Members and visitors must be 18+ and can post adult content."
        }
    }

    public var image: SystemImage? {
        switch communityContent {
        case .familyFriendly:
            return .figureAndChildHoldingHands
        case .adultContent:
            return .exclamationmarkTriangle
        }
    }

    public var id: String {
        title
    }

    // Initialize with the original type
    public init(_ communityContent: CommunityContent) {
        self.communityContent = communityContent
    }
}
