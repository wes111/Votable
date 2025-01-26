//
//  PostCardViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/23.
//

import DemocracySwiftUI
import Foundation
import SharedResourcesClientAndServer

extension PostCardViewModel {
    static let preview = PostCardViewModel(post: .preview)
    
    static let previewArray: [PostCardViewModel] = [
        preview, preview, preview, preview, preview
    ]
}
