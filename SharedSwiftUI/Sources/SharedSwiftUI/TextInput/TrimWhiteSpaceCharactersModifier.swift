//
//  TrimWhiteSpaceCharactersModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/20/23.
//

import Combine
import SwiftUI

public extension View {
    func trimWhiteSpace(text: Binding<String>) -> some View {
        modifier(TrimWhiteSpaceCharactersModifier(text: text))
    }
}

public struct TrimWhiteSpaceCharactersModifier: ViewModifier {
    @Binding var text: String
    
    public init(text: Binding<String>) {
        self._text = text
    }
    
    public func body(content: Content) -> some View {
        content
            .onReceive(Just(text), perform: { _ in
                text = text.trimmingCharacters(in: .whitespacesAndNewlines)
            })
    }
}
