//
//  CheckboxToggleStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/18/23.
//

import SwiftUI

public struct CheckboxToggleStyle: ToggleStyle {
    @Environment(\.theme) var theme: Theme
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            Button {
                configuration.isOn.toggle()
            } label: {
                Image(systemName: configuration.isOn ? SystemImage.checkmarkSquare.rawValue : SystemImage.square.rawValue)
                    .font(.title)
                    .foregroundStyle(theme.primaryColorScheme.tertiaryText)
            }
            
            configuration.label
                .font(.callout)
                .foregroundStyle(theme.primaryColorScheme.secondaryText)
        }
    }
}

public extension ToggleStyle where Self == CheckboxToggleStyle {
    static var iOSCheckbox: CheckboxToggleStyle { .init() }
}

// MARK: - Preview
#Preview {
    @Previewable @Environment(\.theme) var theme: Theme
    @Previewable @State var isChecked = true
    
    ZStack {
        theme.primaryColorScheme.primaryBackground.ignoresSafeArea()
        
        Toggle(isOn: $isChecked) {
            Text("Toggle Example")
        }
        .toggleStyle(.iOSCheckbox)
    }
}
