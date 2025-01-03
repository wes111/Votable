//
//  SelectablePostCategory.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 1/2/25.
//

import Foundation
import SharedResourcesClientAndServer
import SharedSwiftUI

public struct SelectablePostCategory: SelectableItem {
    public let postCategory: PostCategory
    
    public init(_ postCategory: PostCategory) {
        self.postCategory = postCategory
    }
    
    public var name: String {
        postCategory.name
    }
}
