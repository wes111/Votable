//
//  CandidateViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Foundation
import SharedResourcesClientAndServer

extension CandidateViewModel {
    @MainActor static let preview = CandidateViewModel(candidate: .preview)
}
