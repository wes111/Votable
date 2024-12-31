//
//  SelectableCommunityPoster.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/30/24.
//

import SharedResourcesClientAndServer
import SharedSwiftUI

public struct SelectableCommunityPoster: Selectable {
    public let communityPoster: CommunityPoster

    public static var allCases: [SelectableCommunityPoster] {
        CommunityPoster.allCases.map { SelectableCommunityPoster($0) }
    }

    public static let metaTitle: String = "Allowed Posters"
    public static let metaImage: SystemImage = .personThree

    public var title: String {
        communityPoster.id
    }

    public var subtitle: String? {
        switch communityPoster {
        case .all:
            return "Anyone can post in the community"
        case .leadership:
            return "Only community leadership can create posts"
        case .experts:
            return "Only community experts can create posts"
        }
    }

    public var image: SystemImage? {
        switch communityPoster {
        case .all:
            return .personThree
        case .leadership:
            return .crown
        case .experts:
            return .booksVerticalFill
        }
    }

    public var id: String {
        title
    }

    // Initialize with the original type
    public init(_ communityPoster: CommunityPoster) {
        self.communityPoster = communityPoster
    }
}
