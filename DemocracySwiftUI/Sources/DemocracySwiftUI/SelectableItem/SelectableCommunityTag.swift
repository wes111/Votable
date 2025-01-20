//
//  SelectableCommunityTag.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 1/1/25.
//

import Foundation
import SharedResourcesClientAndServer
import SharedSwiftUI

public struct SelectableCommunityTag: SelectableItem {
    public let communityTag: CommunityTag
    
    public init(_ communityTag: CommunityTag) {
        self.communityTag = communityTag
    }
    
    public var name: String {
        communityTag.name
    }
}
