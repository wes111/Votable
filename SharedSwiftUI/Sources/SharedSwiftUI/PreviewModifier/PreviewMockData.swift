//
//  PreviewMockData.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/29/24.
//

import SwiftUI

// https://www.swiftjectivec.com/making-xcode-previews-faster-with-previewmodifier-in-swiftui/
//struct MockPreviewData: PreviewModifier {
//    
//    func body(content: Content, context: Theme) -> some View {
//        content
//            .environment(\.theme, context)
//    }
//    
//    static func makeSharedContext() async throws -> Theme {
//        ThemeKey.defaultValue
//    }
//}
//
//extension PreviewTrait where T == Preview.ViewTraits {
//    static var mockPreviewData: Self = .modifier(MockPreviewData())
//}

struct StandardPreviewModifier: PreviewModifier {
    func body(content: Content, context: Void) -> some View {
        @Environment(\.theme) var theme: Theme
        
        return ZStack {
            theme.primaryColorScheme.primaryBackground.ignoresSafeArea()
            
            content
                .padding(theme.sizeConstants.screenPadding)
        }
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var standardPreviewModifier: Self = .modifier(StandardPreviewModifier())
}

public enum MockSelectable: String, Selectable {
    case mockOne
    case mockTwo
    case mockThree
    case mockFour
    
    public static let metaTitle: String = "Mock Example"
    public static let metaImage: SystemImage = .tag
    
    public var title: String {
        switch self {
        case .mockOne: "Mock One"
        case .mockTwo: "Mock Two"
        case .mockThree: "Mock Three"
        case .mockFour: "Mock Four"
        }
    }
    
    public var subtitle: String? {
        switch self {
        case .mockOne: "Mock One Subtitle Example"
        case .mockTwo: "Mock Two Subtitle Example"
        case .mockThree: "Mock Three Subtitle Example"
        case .mockFour: "Mock Four Subtitle Example"
        }
    }
    
    public var image: SystemImage? {
        switch self {
        case .mockOne: .arrowRight
        case .mockTwo: .bolt
        case .mockThree: .book
        case .mockFour: .asterisk
        }
    }
}

extension MockSelectable: PasswordCaseRepresentable {
    public var isPasswordCase: Bool {
        true
    }
    
    public static var passwordCase: MockSelectable {
        .mockOne
    }
}
