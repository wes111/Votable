//
//  CategoriesSelectableView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/5/24.
//

import SwiftUI

struct SelectablePickerDetailView<Category: Selectable>: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.theme) var theme: Theme
    @Binding var selectedCategory: Category
    
    var body: some View {
        VStack(alignment: .center, spacing: theme.sizeConstants.extraLargeElementSpacing) {
            header
            selectableContent
        }
        .frame(alignment: .topLeading)
        .padding(.top, theme.sizeConstants.partialSheetTopPadding)
        .padding([.horizontal, .bottom], theme.sizeConstants.screenPadding)
        .background(theme.primaryColorScheme.secondaryBackground, ignoresSafeAreaEdges: .all)
    }
}

// MARK: - Subviews
private extension SelectablePickerDetailView {
    
    var header: some View {
        VStack(alignment: .leading, spacing: theme.sizeConstants.smallElementSpacing) {
            closeButton
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text("Select a \(Category.metaTitle)")
                .font(.system(.title2, weight: .semibold))
                .multilineTextAlignment(.leading)
                .foregroundStyle(theme.primaryColorScheme.primaryText)
        }
    }
    
    var selectableContent: some View {
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
    
    var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: SystemImage.xMark.rawValue)
                .foregroundColor(theme.primaryColorScheme.tertiaryText)
        }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var mockSelectable: MockSelectable = .mockTwo
    
    SelectablePickerDetailView(
        selectedCategory: $mockSelectable
    )
}
