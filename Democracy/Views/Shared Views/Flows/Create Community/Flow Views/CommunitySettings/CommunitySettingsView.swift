//
//  CommunitySettingsView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import DemocracySwiftUI
import SharedSwiftUI
import SwiftUI
import SharedResourcesClientAndServer

struct CommunitySettingsView: View {
    @State var viewModel: CommunitySettingsViewModel
    @Environment(\.theme) var theme: Theme
    
    var body: some View {
        VStack(alignment: .leading, spacing: theme.sizeConstants.elementSpacing) {
            settingsView
            Spacer()
            SubmittableNextButton(viewModel: viewModel)
        }
        .onAppear {
            viewModel.setUserInput()
        }
    }
}

// MARK: - Subviews
private extension CommunitySettingsView {
    
    var settingsView: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: theme.sizeConstants.largeElementSpacing) {
                SelectableSheetPickerView(
                    selection: Binding(
                        get: { SelectableCommunityGovernment(viewModel.settings.government) },
                        set: { viewModel.settings.government = $0.communityGovernment }
                    )
                )
                
                SelectableSheetPickerView(
                    selection: Binding(
                        get: { SelectableCommunityContent(viewModel.settings.content) },
                        set: { viewModel.settings.content = $0.communityContent }
                    )
                )
                
                SelectableSheetPickerView(
                    selection: Binding(
                        get: { SelectableCommunityVisibility(viewModel.settings.visibility) },
                        set: { viewModel.settings.visibility = $0.communityVisibility }
                    )
                )
                
                SelectableSheetPickerView(
                    selection: Binding(
                        get: { SelectableCommunityPoster(viewModel.settings.poster) },
                        set: { viewModel.settings.poster = $0.communityPoster }
                    )
                )
                
                SelectableSheetPickerView(
                    selection: Binding(
                        get: { SelectableCommunityCommenter(viewModel.settings.commenter) },
                        set: { viewModel.settings.commenter = $0.communityCommenter }
                    )
                )
                
                SelectableSheetPickerView(
                    selection: Binding(
                        get: { SelectableCommunityPostApproval(viewModel.settings.postApproval) },
                        set: { viewModel.settings.postApproval = $0.communityPostApproval }
                    )
                )
            }
            .padding(theme.sizeConstants.smallInnerBorder)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityInputFlowView(flowPath: .settings)
    }
}
