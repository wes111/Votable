//
//  ExpandableTextView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 8/21/24.
//

import SwiftUI
import SharedResourcesClientAndServer

public struct ExpandableTextView: View {
    @Environment(\.theme) var theme: Theme
    @State private var isExpanded: Bool = false
    let text: String
    let lineLimit: Int
    
    public init(
        text: String,
        lineLimit: Int = 5
    ) {
        self.text = text
        self.lineLimit = lineLimit
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.sizeConstants.smallElementSpacing) {
            Text(text)
                .font(.callout)
                .fontWeight(.regular)
                .lineLimit(isExpanded ? nil : lineLimit)
                .animation(.easeInOut, value: isExpanded)
                .foregroundStyle(theme.primaryColorScheme.primaryText)
            
            Button {
                isExpanded.toggle()
            } label: {
                Label {
                    Text(isExpanded ? "Less" :"More")
                } icon: {
                    Image(systemName: isExpanded ? SystemImage.chevronUp.rawValue : SystemImage.chevronDown.rawValue)
                }
                .labelStyle(ReversedLabelStyle())
            }
            .buttonStyle(ExtraSmallSecondaryButtonStyle())
        }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @Environment(\.theme) var theme: Theme
    ExpandableTextView(text: Candidate.preview.summary)
        .background(theme.primaryColorScheme.primaryBackground, ignoresSafeAreaEdges: .all)
}
