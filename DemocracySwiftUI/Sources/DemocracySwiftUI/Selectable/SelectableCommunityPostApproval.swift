//
//  SelectableCommunityPostApproval.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/30/24.
//

import SharedResourcesClientAndServer
import SharedSwiftUI

public struct SelectableCommunityPostApproval: Selectable {
    public let communityPostApproval: CommunityPostApproval

    public static var allCases: [SelectableCommunityPostApproval] {
        CommunityPostApproval.allCases.map { SelectableCommunityPostApproval($0) }
    }

    public static let metaTitle: String = "Post Approval Process"
    public static let metaImage: SystemImage = .checkmarkCircleFill

    public var title: String {
        communityPostApproval.id
    }

    public var subtitle: String? {
        switch communityPostApproval {
        case .automatic:
            return "Posts are approved automatically"
        case .mod:
            return "Posts are approved by Community mods"
        }
    }

    public var image: SystemImage? {
        switch communityPostApproval {
        case .automatic:
            return .bolt
        case .mod:
            return .checkmark
        }
    }

    public var id: String {
        title
    }

    // Initialize with the original type
    public init(_ communityPostApproval: CommunityPostApproval) {
        self.communityPostApproval = communityPostApproval
    }
}
