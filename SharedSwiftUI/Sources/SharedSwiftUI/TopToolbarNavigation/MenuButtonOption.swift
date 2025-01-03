//
//  MenuButtonOption.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/29/24.
//

import SwiftUI

public struct MenuButtonOption: Identifiable {
    public let title: String
    public let action: () -> Void
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var id: String {
        title
    }
}
