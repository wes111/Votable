//
//  CandidateCardViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Foundation
import SharedResourcesClientAndServer

extension CandidateCardViewModel {
    
    @MainActor static let preview = CandidateCardViewModel(
        candidate: Candidate.preview
    )
}
