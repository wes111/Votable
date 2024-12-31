//
//  ExpandableTextView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 8/21/24.
//

import SharedSwiftUI
import SwiftUI
import SharedResourcesClientAndServer

struct ExpandableTextView: View {
    @State private var isExpanded: Bool = false
    
    let text: String
    let lineLimit: Int = 5
    
    var body: some View {
        VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
            Text(text)
                .font(.callout)
                .fontWeight(.regular)
                .lineLimit(isExpanded ? nil : lineLimit)
                .animation(.easeInOut, value: isExpanded)
                .foregroundStyle(Color.primaryText)
            
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
    ExpandableTextView(text: Candidate.preview.summary)
        .background(Color.primaryBackground, ignoresSafeAreaEdges: .all)
}
