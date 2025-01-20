//
//  SelectableCommunityCommenter.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/30/24.
//

import Foundation
import SharedResourcesClientAndServer
import SharedSwiftUI

public struct SelectableCommunityCommenter: Selectable {
    public let communityCommenter: CommunityCommenter

    public static var allCases: [SelectableCommunityCommenter] {
        CommunityCommenter.allCases.map { SelectableCommunityCommenter($0) }
    }

    public static let metaTitle: String = "Allowed Commenters"
    public static let metaImage: SystemImage = .personThree

    public var title: String {
        communityCommenter.id
    }

    public var subtitle: String? {
        switch communityCommenter {
        case .all:
            return "Anyone can post in the community"
        case .leadership:
            return "Only community leadership can create posts"
        case .experts:
            return "Only community experts can create posts"
        }
    }

    public var image: SystemImage? {
        switch communityCommenter {
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
    public init(_ communityCommenter: CommunityCommenter) {
        self.communityCommenter = communityCommenter
    }
}
