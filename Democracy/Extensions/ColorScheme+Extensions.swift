//
//  ColorScheme+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/29/24.
//
import SharedSwiftUI

extension ColorScheme {
    @MainActor static let primary: ColorScheme = {
        .init(
            primaryBackground: .primaryBackground,
            secondaryBackground: .secondaryBackground,
            tertiaryBackground: .tertiaryBackground,
            quaternaryBackground: .quadBackground,
            primaryText: .primaryText,
            secondaryText: .secondaryText,
            tertiaryText: .tertiaryText,
            primaryAccent: .primaryAccent,
            secondaryAccent: .secondaryAccent
        )
    }()
    
    @MainActor static let sheet: ColorScheme = {
        .init(
            primaryBackground: .secondaryBackground,
            secondaryBackground: .tertiaryBackground,
            tertiaryBackground: .quadBackground,
            quaternaryBackground: .white,
            primaryText: .secondaryText,
            secondaryText: .tertiaryText,
            tertiaryText: .black,
            primaryAccent: .primaryAccent,
            secondaryAccent: .secondaryAccent
        )
    }()
}
