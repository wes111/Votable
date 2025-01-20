//
//  TopBarContent.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/29/24.
//

import Foundation

public enum TopBarContent: Identifiable {
    public typealias Action = () -> Void
    
    case title(String, size: NavigationTitleSize)
    case back(Action)
    case close(Action)
    case search(Action)
    case menu([MenuButtonOption])
    case filter(Action)

    public var id: String {
        switch self {
        case .title:
            "title"
        case .back:
            "back"
        case .close:
            "close"
        case .search:
            "search"
        case .menu:
            "menu"
        case .filter:
            "filter"
        }
    }
}
