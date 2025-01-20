//
//  ThemeKey.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/31/24.
//

import SwiftUI

// We can't use the new `Entry` macro here in a SPM package, as there is no good
// way to inject the environment value from an ancester view.
struct ThemeKey: EnvironmentKey {
    static let defaultValue: Theme = .defaultTheme
}

public extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}
