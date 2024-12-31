//
//  SelectableCommunityCategory.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/30/24.
//

import SharedResourcesClientAndServer
import SharedSwiftUI

public struct SelectableCommunitiesCategory: Selectable {
    public let communitiesCategory: CommunitiesCategory

    public static var allCases: [SelectableCommunitiesCategory] {
        CommunitiesCategory.allCases.map { SelectableCommunitiesCategory($0) }
    }

    public static let metaTitle: String = "Communities Category"
    public static let metaImage: SystemImage = .personThree

    public var title: String {
        communitiesCategory.id
    }

    public var subtitle: String? {
        nil
    }

    public var image: SystemImage? {
        switch communitiesCategory {
        case .isMemberOf:
            return .personThree
        case .isLeaderOf:
            return .crown
        case .topCommunities:
            return .starFill
        case .random:
            return .shuffle
        case .recommendations:
            return .link
        }
    }

    public var id: String {
        title
    }

    // Initialize with the original type
    public init(_ communitiesCategory: CommunitiesCategory) {
        self.communitiesCategory = communitiesCategory
    }
}
