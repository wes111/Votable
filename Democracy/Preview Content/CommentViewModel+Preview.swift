//
//  CommentViewModel +Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/11/24.
//

import DemocracySwiftUI
import Foundation
import SharedResourcesClientAndServer

extension CommentViewModel {
    static let preview = CommentViewModel(
        comment: CommentNode(value: ObservableComment.preview),
        delegate: nil
    )
}
