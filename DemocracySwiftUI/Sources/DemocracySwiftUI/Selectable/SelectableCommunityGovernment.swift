//
//  SelectableCommunityGovernment.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 12/30/24.
//

import Foundation
import SharedResourcesClientAndServer
import SharedSwiftUI

public struct SelectableCommunityGovernment: Selectable {
    public let communityGovernment: CommunityGovernment

    public static var allCases: [SelectableCommunityGovernment] {
        CommunityGovernment.allCases.map { SelectableCommunityGovernment($0) }
    }

    public static let metaTitle: String = "Government Type"
    public static let metaImage: SystemImage = .buildingColumns

    public var title: String {
        communityGovernment.id
    }

    public var subtitle: String? {
        switch communityGovernment {
        case .autocracy:
            return "Community leaders are self-appointed and cannot be removed by member consensus."
        case .democracy:
            return "Leaders are elected and removed by member consensus."
        }
    }

    public var image: SystemImage? {
        switch communityGovernment {
        case .autocracy:
            return .person
        case .democracy:
            return .personThree
        }
    }

    public var id: String {
        title
    }

    // Initialize with the original type
    public init(_ communityGovernment: CommunityGovernment) {
        self.communityGovernment = communityGovernment
    }
}
