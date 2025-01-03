//
//  SelectablePickerDetailNavigationView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/29/24.
//

import SwiftUI

public struct SelectablePickerDetailNavigationView<Category: Selectable>: View {
    @Environment(\.theme) var theme: Theme
    @Binding var selectedCategory: Category
    let backAction: () -> Void
    
    public init(selectedCategory: Binding<Category>, backAction: @escaping () -> Void) {
        self._selectedCategory = selectedCategory
        self.backAction = backAction
    }
    
    public var body: some View {
        content
            .frame(maxHeight: .infinity, alignment: .topLeading)
            .background(theme.primaryColorScheme.secondaryBackground, ignoresSafeAreaEdges: .all)
            .toolbarNavigation(
                leadingContent: leadingToolbarContent,
                centerContent: centerToolbarContent
            )
    }
}

// MARK: - Subviews
private extension SelectablePickerDetailNavigationView {
    
    var content: some View {
        VStack(alignment: .leading, spacing: theme.sizeConstants.elementSpacing) {
            selectableContent
            selectButton
        }
        .padding(theme.sizeConstants.screenPadding)
    }
    
    var leadingToolbarContent: [TopBarContent] {
        [.back(backAction)]
    }
    
    var centerToolbarContent: [TopBarContent] {
        [.title("Select a \(Category.metaTitle)", size: .small)]
    }
    
    var selectableContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.sizeConstants.smallElementSpacing) {
                ForEach(Category.allCases, id: \.self) { category in
                    SelectableView(
                        isSelected: selectedCategory == category,
                        title: category.title,
                        subtitle: category.subtitle,
                        image: category.image
                    )
                    .onTapGesture {
                        selectedCategory = category
                    }
                }
            }
        }
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
    }
    
    var selectButton: some View {
        Button {
            backAction()
        } label: {
            Text("Select")
        }
        .buttonStyle(SecondaryButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var mockSelectable: MockSelectable = .mockFour
    
    SelectablePickerDetailNavigationView(
        selectedCategory: $mockSelectable,
        backAction: {}
    )
}
