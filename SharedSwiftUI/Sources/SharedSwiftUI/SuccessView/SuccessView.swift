//
//  SuccessView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/7/24.
//

import SwiftUI

public struct ButtonInfo {
    public let title: String
    public let action: () -> Void
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}

// Generic success view.
@MainActor
public struct SuccessView<ViewModel: SuccessViewModel>: View {
    @Environment(\.theme) var theme: Theme
    private let viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            topLogo
            centerContent
            bottomButtons
        }
        .padding(theme.sizeConstants.screenPadding)
        .background(theme.primaryColorScheme.primaryBackground, ignoresSafeAreaEdges: .all)
        .toolbarNavigation(trailingContent: [.close(viewModel.closeAction)], theme: theme)
    }
    
    // MARK: - Subviews
    var topLogo: some View { // TODO: This could be more generic.
        VStack {
            Image(systemName: viewModel.imageType.rawValue)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100)
                .foregroundStyle(Color.green)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    var centerContent: some View {
        VStack(alignment: .center, spacing: theme.sizeConstants.smallElementSpacing) {
            Spacer()
            Text(viewModel.primaryText)
                .font(.system(.title, weight: .semibold))
                .foregroundColor(theme.primaryColorScheme.primaryText)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
            
            Text(viewModel.secondaryText)
                .font(.system(.body, weight: .regular))
                .foregroundColor(theme.primaryColorScheme.tertiaryText)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    var bottomButtons: some View {
        VStack(alignment: .leading, spacing: theme.sizeConstants.elementSpacing) {
            Spacer()
            primaryButton
            
            if let secondaryButtonInfo = viewModel.secondaryButtonInfo {
                secondaryButton(info: secondaryButtonInfo)
            }
        }
    }
    
    var primaryButton: some View {
        Button {
            viewModel.primaryButtonInfo.action()
        } label: {
            Label {
                Text(viewModel.primaryButtonInfo.title)
            } icon: {
                Image(systemName: "arrow.right")
            }
            .labelStyle(ReversedLabelStyle())
        }
        .buttonStyle(PrimaryButtonStyle())
    }
    
    func secondaryButton(info: ButtonInfo) -> some View {
        Button {
            info.action()
        } label: {
            Text(info.title)
        }
        .buttonStyle(SecondaryButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    SuccessView(viewModel: SuccessViewModelMock())
}
