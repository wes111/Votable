//
//  ButtonStyle.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/29/24.
//

import SwiftUI

public struct ExtraSmallSecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.theme) var theme: Theme
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(theme.primaryColorScheme.primaryText)
            .font(.caption)
            .fontWeight(.bold)
            .padding(.vertical, theme.sizeConstants.extraSmallInnerBorder)
            .padding(.horizontal, theme.sizeConstants.smallInnerBorder)
            .overlay(
                Capsule()
                    .stroke(
                        theme.primaryColorScheme.tertiaryText,
                        style: StrokeStyle(lineWidth: 1)
                    )
             )
            .contentShape(Capsule())
            .opacity(configuration.isPressed || !isEnabled ? 0.5 : 1.0)
    }
}

public struct SmallSecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.theme) var theme: Theme
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(theme.primaryColorScheme.primaryText)
            .font(.callout)
            .lineLimit(1)
            .fontWeight(.bold)
            .padding(theme.sizeConstants.smallInnerBorder)
            .frame(width: 75)
            .overlay(
                Capsule()
                    .stroke(
                        theme.primaryColorScheme.tertiaryText,
                        style: StrokeStyle(lineWidth: 1)
                    )
             )
            .contentShape(Capsule())
            .opacity(configuration.isPressed || !isEnabled ? 0.5 : 1.0)
    }
}

public struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.theme) var theme: Theme
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(theme.primaryColorScheme.primaryText)
            .font(.callout)
            .fontWeight(.bold)
            .padding()
            .frame(maxWidth: .infinity)
            .overlay(
                Capsule()
                    .stroke(
                        theme.primaryColorScheme.tertiaryText,
                        style: StrokeStyle(lineWidth: 1)
                    )
             )
            .contentShape(Capsule())
            .opacity(configuration.isPressed ? 0.3 : 1.0)
    }
}

public struct SmallImageButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.theme) var theme: Theme
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        Circle()
            .fill(theme.primaryColorScheme.primaryAccent)
            .frame(height: theme.sizeConstants.smallButtonRadius)
            .overlay(
                configuration.label
                    .fontWeight(.bold)
                    .foregroundStyle(theme.primaryColorScheme.primaryText)
            )
            .foregroundStyle(theme.primaryColorScheme.primaryText)
            .fontWeight(.bold)
            .contentShape(Circle())
            .opacity(configuration.isPressed || !isEnabled ? 0.5 : 1.0)
    }
}

public struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.theme) var theme: Theme
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(theme.primaryColorScheme.primaryText)
            .font(.callout)
            .fontWeight(.bold)
            .padding()
            .frame(maxWidth: .infinity)
            .background(theme.primaryColorScheme.primaryAccent, in: Capsule())
            .opacity(configuration.isPressed || !isEnabled ? 0.5 : 1.0)
    }
}

public struct TertiaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.theme) var theme: Theme
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(theme.primaryColorScheme.secondaryText)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, theme.sizeConstants.innerBorder)
            .padding(.vertical, theme.sizeConstants.smallInnerBorder)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(theme.primaryColorScheme.secondaryBackground)
            )
            .contentShape(Capsule())
            .opacity(configuration.isPressed ? 0.3 : 1.0)
    }
}

// MARK: - Preview
#Preview {
    @Previewable @Environment(\.theme) var theme: Theme
    
    ZStack {
        theme.primaryColorScheme.primaryBackground.ignoresSafeArea()
        
        VStack(spacing: 25) {
            Button {
                print()
            } label: {
                Text("Submit")
            }
            .buttonStyle(PrimaryButtonStyle())
            
            Button {
                print()
            } label: {
                Text("Submit")
            }
            .buttonStyle(SecondaryButtonStyle())
            
            Button {
                print()
            } label: {
                Text("Join")
            }
            .buttonStyle(SmallSecondaryButtonStyle())
            
            Button {
                print()
            } label: {
                Text("Join")
            }
            .buttonStyle(ExtraSmallSecondaryButtonStyle())
            
            Button(action: {}) {
                Image(systemName: SystemImage.plus.rawValue)
            }
            .buttonStyle(SmallImageButtonStyle())
            
            Button {
                print()
            } label: {
                Text("Load Replies")
            }
            .buttonStyle(TertiaryButtonStyle())
        }
    }
    .ignoresSafeArea()
}
