//
//  CharacterLimiterModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/18/23.
//

import Combine
import SwiftUI

// https://stackoverflow.com/questions/56476007/swiftui-textfield-max-length
public extension View {
    func limitCharacters(text: Binding<String>, count: Int) -> some View {
        modifier(CharacterLimiterModifier(text: text, limit: count))
    }
}

fileprivate struct CharacterLimiterModifier: ViewModifier {
    @Binding var text: String
    let limit: Int
    
    func body(content: Content) -> some View {
        content
            .onReceive(Just(text)) { _ in limitText(limit) }
    }
    
    private func limitText(_ upper: Int) {
        if text.count > upper {
            text = String(text.prefix(upper))
        }
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    @Previewable @State var text: String = "Preview Text"
    
    TextField("Preview", text: $text)
        .limitCharacters(text: $text, count: 25)
}
