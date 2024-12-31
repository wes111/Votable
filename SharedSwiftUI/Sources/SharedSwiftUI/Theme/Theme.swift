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
