//
//  CustomPicker.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/18/24.
//

import SwiftUI

// Standardized Picker
// Purpose is to wrap the UIKit in the initializer.
public struct CustomPicker<Selection: Hashable, Content: View>: View {
    @Environment(\.theme) private var theme: Theme
    @ViewBuilder let content: Content
    let title: String
    var selection: Binding<Selection>
    
    public init(
        title: String,
        selection: Binding<Selection>,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.selection = selection
        self.content = content()
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.init(theme.primaryColorScheme.secondaryBackground)
        UISegmentedControl.appearance().backgroundColor = UIColor.init(theme.primaryColorScheme.primaryBackground)
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.init(theme.primaryColorScheme.secondaryText)],
            for: .normal
        )
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.init(theme.primaryColorScheme.primaryText)],
            for: .selected
        )
    }
    
    public var body: some View {
        Picker(title, selection: selection) {
            content
        }
        .pickerStyle(.segmented)
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    @Previewable @State var selection: MockSelectable = .mockOne
    
    CustomPicker(title: "Picker", selection: $selection) {
        ForEach(MockSelectable.allCases, id: \.self) { selection in
            Text(selection.rawValue.capitalized)
                .tag(selection)
        }
    }
}
