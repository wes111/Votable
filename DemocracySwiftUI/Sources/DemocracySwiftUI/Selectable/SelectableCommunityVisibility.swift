//
//  SelectableCommunityVisibility.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/30/24.
//

import Foundation
import SharedResourcesClientAndServer
import SharedSwiftUI

public struct SelectableCommunityVisibility: Selectable {
    public let communityVisibility: CommunityVisibility

    public static var allCases: [SelectableCommunityVisibility] {
        CommunityVisibility.allCases.map { SelectableCommunityVisibility($0) }
    }

    public static let metaTitle: String = "Community Visibility"
    public static let metaImage: SystemImage = .eye

    public var title: String {
        communityVisibility.id
    }

    public var subtitle: String? {
        switch communityVisibility {
        case .all:
            return "Visible to everyone"
        case .member:
            return "Visible to community members only"
        }
    }

    public var image: SystemImage? {
        switch communityVisibility {
        case .all:
            return .eye
        case .member:
            return .eyeSlash
        }
    }

    public var id: String {
        title
    }

    // Initialize with the original type
    public init(_ communityVisibility: CommunityVisibility) {
        self.communityVisibility = communityVisibility
    }
}
