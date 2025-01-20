//
//  ButtonInfo.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 1/17/25.
//

import Foundation

@MainActor
public struct ButtonInfo {
    public let title: String
    public let action: () -> Void
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}
