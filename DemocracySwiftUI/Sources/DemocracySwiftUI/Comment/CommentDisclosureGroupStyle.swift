//
//  CommentDisclosureGroupStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/11/24.
//

import SharedSwiftUI
import SwiftUI

public struct CommentDisclosureGroupStyle: DisclosureGroupStyle {
    @Environment(\.theme) var theme: Theme
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .bottomTrailing) {
            configuration.label
            
            Button {
                configuration.isExpanded.toggle()
            } label: {
                Label {
                    Text("\(configuration.isExpanded ? "Hide" : "View") Replies")
                } icon: {
                    Image(systemName: !configuration.isExpanded ? 
                          SystemImage.chevronDown.rawValue : SystemImage.chevronUp.rawValue
                    )
                }
                .labelStyle(ReversedLabelStyle())
                .font(.footnote)
            }
            .foregroundStyle(Color.white)
            .padding(.trailing, theme.sizeConstants.screenPadding)
            .padding(.bottom, theme.sizeConstants.smallElementSpacing)
        }
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listRowBackground(theme.primaryColorScheme.primaryBackground)
        .listRowSeparator(.hidden)
        
        if configuration.isExpanded {
            configuration.content
                .disclosureGroupStyle(self)
        }
    }
}
