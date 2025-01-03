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
                secondaryBackground: .secondaryBackground,
                tertiaryBackground: .tertiaryBackground,
                quaternaryBackground: .quadBackground,
                primaryText: .primaryText,
                secondaryText: .secondaryText,
                tertiaryText: .tertiaryText,
                primaryAccent: .otherRed,
                secondaryAccent: .otherRed
            )
        }()
        
        let sheetColorScheme: ColorScheme = {
            .init(
                primaryBackground: .secondaryBackground,
                secondaryBackground: .tertiaryBackground,
                tertiaryBackground: .quadBackground,
                quaternaryBackground: .white,
                primaryText: .secondaryText,
                secondaryText: .tertiaryText,
                tertiaryText: .black,
                primaryAccent: .otherRed,
                secondaryAccent: .otherRed
            )
        }()
        
        return .init(
            primaryColorScheme: primaryColorScheme,
            sheetColorScheme: sheetColorScheme,
            sizeConstants: sizeConstants
        )
    }()
}
