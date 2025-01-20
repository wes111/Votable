//
//  ObservableComment+Mock.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/13/24.
//

import Foundation

public extension ObservableComment {
    
    static var preview: ObservableComment {
        ObservableComment(
            id: "",
            parentId: "",
            postId: "",
            userId: "",
            creationDate: .now,
            content: "Post body Content - Hello World!",
            upVoteCount: 10,
            downVoteCount: 5,
            responseCount: 11,
            score: 10 - 5
        )
    }
}
