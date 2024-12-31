//
//  PostCardViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/23.
//

import Foundation
import SharedResourcesClientAndServer

extension PostCardViewModel {
    static let preview = PostCardViewModel(coordinator: CommunitiesCoordinator.preview, post: Post.preview)
    
    static let previewArray: [PostCardViewModel] = [
        preview, preview, preview, preview, preview
    ]
}
