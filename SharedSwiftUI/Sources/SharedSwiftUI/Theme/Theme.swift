//
//  Theme.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/29/24.
//

import Foundation

public struct Theme: Sendable {
    public let primaryColorScheme: ColorScheme
    public let sheetColorScheme: ColorScheme
    public let sizeConstants: SizeConstants
    
    public init(
        primaryColorScheme: ColorScheme,
        sheetColorScheme: ColorScheme,
        sizeConstants: SizeConstants
    ) {
        self.primaryColorScheme = primaryColorScheme
        self.sheetColorScheme = sheetColorScheme
        self.sizeConstants = sizeConstants
    }
}

extension Theme {
    static let defaultTheme: Theme = {
        let sizeConstants: SizeConstants = {
            .init(
                extraSmallElementSpacing: 4,
                smallElementSpacing: 8,
                elementSpacing: 12,
                largeElementSpacing: 16,
                extraLargeElementSpacing: 20,
                sectionSpacing: 16,
                sectionIndent: 20,
                innerBorder: 16,
                smallInnerBorder: 8,
                extraSmallInnerBorder: 4,
                textFieldPadding: 15,
                textEditorPadding: 17.5,
                smallTextInputPadding: 5,
                animationLength: 0.3,
                minTextScale: 0.75,
                cornerRadius: 10,
                screenPadding: 16,
                partialSheetTopPadding: 20,
                thinBorderWidth: 2,
                borderWidth: 3,
                dimmingBrightness: -0.1,
                smallButtonRadius: 35,
                sheetBottomPadding: 32,
                scrollViewTopContentMargin: 16
            )
        }()
        
        let primaryColorScheme: ColorScheme = {
            .init(
                primaryBackground: .black,
                secondaryBackground: .init(red: 30 / 255, green: 30 / 255, blue: 30 / 255),
                tertiaryBackground: .init(red: 47 / 255, green: 47 / 255, blue: 47 / 255),
                quaternaryBackground: .init(red: 93 / 255, green: 93 / 255, blue: 93 / 255),
                primaryText: .init(red: 238  / 255, green: 238  / 255, blue: 238  / 255),
                secondaryText: .init(red: 208 / 255, green: 208 / 255, blue: 208 / 255),
                tertiaryText: .init(red: 188 / 255, green: 188 / 255, blue: 188 / 255),
                primaryAccent: .init(red: 165 / 255, green: 4 / 255, blue: 4 / 255),
                secondaryAccent: .init(red: 165 / 255, green: 4 / 255, blue: 4 / 255)
            )
        }()
        
        let sheetColorScheme: ColorScheme = {
            .init(
                primaryBackground: .init(red: 30 / 255, green: 30 / 255, blue: 30 / 255),
                secondaryBackground: .init(red: 47 / 255, green: 47 / 255, blue: 47 / 255),
                tertiaryBackground: .init(red: 93 / 255, green: 93 / 255, blue: 93 / 255),
                quaternaryBackground: .white,
                primaryText: .init(red: 208 / 255, green: 208 / 255, blue: 208 / 255),
                secondaryText: .init(red: 188 / 255, green: 188 / 255, blue: 188 / 255),
                tertiaryText: .black,
                primaryAccent: .init(red: 165 / 255, green: 4 / 255, blue: 4 / 255),
                secondaryAccent: .init(red: 165 / 255, green: 4 / 255, blue: 4 / 255)
            )
        }()
        
        return .init(
            primaryColorScheme: primaryColorScheme,
            sheetColorScheme: sheetColorScheme,
            sizeConstants: sizeConstants
        )
    }()
}
