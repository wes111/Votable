//
//  VoteButtons.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/28/24.
//

import SharedResourcesClientAndServer
import SharedSwiftUI
import SwiftUI

public struct VoteButtons: View {
    @Environment(\.theme) var theme: Theme
    private let didTapVoteButton: (VoteType) -> Void
    private var upVoteCount: Int
    private var downVoteCount: Int
    
    public init(didTapVoteButton: @escaping (VoteType) -> Void, upVoteCount: Int, downVoteCount: Int) {
        self.didTapVoteButton = didTapVoteButton
        self.upVoteCount = upVoteCount
        self.downVoteCount = downVoteCount
    }
    
    public var body: some View {
        content
    }
}

// MARK: - Subviews
private extension VoteButtons {
    
    var content: some View {
        HStack(alignment: .center, spacing: theme.sizeConstants.elementSpacing) {
            upVoteButton
            downVoteButton
        }
        .font(.footnote)
        .foregroundStyle(theme.primaryColorScheme.secondaryText)
    }
    
    var upVoteButton: some View {
        Button {
            didTapVoteButton(.up)
        } label: {
            Label {
                Text("\(upVoteCount)")
            } icon: {
                Image(systemName: SystemImage.arrowshapeUp.rawValue)
            }
            .labelStyle(TightLabelStyle())
        }
        .buttonStyle(.plain)
    }
    
    var downVoteButton: some View {
        Button {
            didTapVoteButton(.down)
        } label: {
            Label {
                Text("\(downVoteCount)")
            } icon: {
                Image(systemName: SystemImage.arrowshapeDown.rawValue)
            }
            .labelStyle(TightLabelStyle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    VoteButtons(
        didTapVoteButton: { _ in },
        upVoteCount: 5,
        downVoteCount: 10
    )
}
