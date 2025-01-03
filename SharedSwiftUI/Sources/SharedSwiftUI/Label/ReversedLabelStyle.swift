//
//  ReversedLabelStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/7/23.
//

import SwiftUI

public struct ReversedLabelStyle: LabelStyle {
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

// MARK: - Preview
#Preview {
    Label("Label Title", systemImage: "chevron.right")
        .labelStyle(ReversedLabelStyle())
}
