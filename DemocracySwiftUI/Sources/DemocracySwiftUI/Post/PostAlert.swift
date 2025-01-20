//
//  PostAlert.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 1/1/25.
//

import Foundation
import SharedSwiftUI

public enum PostAlert: AlertModelProtocol {
    case submitCommentFailed
    case fetchInitialCommentsFailed
    
    public var title: String {
        switch self {
        case .submitCommentFailed:
            "Submit Comment Failed"
        case .fetchInitialCommentsFailed:
            "Fetch Initial Comments Failed"
        }
    }
    
    public var description: String {
        switch self {
        case .submitCommentFailed, .fetchInitialCommentsFailed:
            "Please try again later."
        }
    }
}
