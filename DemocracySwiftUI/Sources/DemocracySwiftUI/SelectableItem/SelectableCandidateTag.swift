//
//  SelectableCandidateTag.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 1/2/25.
//

import Foundation
import SharedResourcesClientAndServer
import SharedSwiftUI

public struct SelectableCandidateTag: SelectableItem {
    public let candidateTag: CandidateTag
    
    public init(_ candidateTag: CandidateTag) {
        self.candidateTag = candidateTag
    }
    
    public var name: String {
        candidateTag.name
    }
}
