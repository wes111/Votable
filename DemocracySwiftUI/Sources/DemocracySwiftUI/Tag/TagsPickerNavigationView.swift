//
//  TagsPickerNavigationView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/29/24.
//

import SharedSwiftUI
import SwiftUI
import SharedResourcesClientAndServer

@MainActor
public struct TagsPickerNavigationView: View {
    @Environment(\.theme) var theme: Theme
    let backAction: () -> Void
    let toggleTagAction: (SelectableCommunityTag) -> Void
    let availableTags: [SelectableCommunityTag]
    var selectedTags: [SelectableCommunityTag]
    
    public init(
        backAction: @escaping () -> Void,
        toggleTagAction: @escaping (SelectableCommunityTag) -> Void,
        availableTags: [SelectableCommunityTag],
        selectedTags: [SelectableCommunityTag]
    ) {
        self.backAction = backAction
        self.toggleTagAction = toggleTagAction
        self.availableTags = availableTags
        self.selectedTags = selectedTags
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
private extension TagsPickerNavigationView {
    
    var content: some View {
        VStack(alignment: .leading, spacing: theme.sizeConstants.elementSpacing) {
            selectableContent
            selectButton
        }
        .padding(theme.sizeConstants.screenPadding)
    }
    
    var selectButton: some View {
        Button {
            backAction()
        } label: {
            Text("Select")
        }
        .buttonStyle(SecondaryButtonStyle())
    }
    
    var leadingToolbarContent: [TopBarContent] {
        [.back(backAction)]
    }
    
    var centerToolbarContent: [TopBarContent] {
        [.title("Select Tags", size: .small)]
    }
    
    var selectableContent: some View {
        TagsFlow(
            selectedItems: selectedTags,
            items: availableTags,
            tagAction: SelectableItemAction.toggleItem(toggleTagAction)
        )
    }
}

// MARK: - Preview
#Preview {
    @Previewable @Environment(\.theme) var theme: Theme
    
    ZStack {
        theme.primaryColorScheme.primaryBackground.ignoresSafeArea()
        NavigationStack {
            TagsPickerNavigationView(
                backAction: {
                    return
                },
                toggleTagAction: { _ in
                    return
                },
                availableTags: [],
                selectedTags: [])
        }
    }
}
