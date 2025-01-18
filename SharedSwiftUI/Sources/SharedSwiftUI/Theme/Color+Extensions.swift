//
//  Color+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/7/23.
//

import Foundation
import SwiftUI

extension Color {
    
    // MARK: - Background Colors
    

    static var primaryBackground: Color {
        .black
    }
    
    /// Dark gray.
    static var secondaryBackground: Color {
        .init(red: 30 / 255, green: 30 / 255, blue: 30 / 255)

    }
    
    /// Medium gray.
    static var tertiaryBackground: Color {
        .init(red: 47 / 255, green: 47 / 255, blue: 47 / 255)

    }
    
    // I don't think we will want to use this, but just in case...
    static var quadBackground: Color {
        .init(red: 93 / 255, green: 93 / 255, blue: 93 / 255)
    }
    
    // MARK: - Text Colors
    
    static var primaryText: Color {
        .init(red: 238  / 255, green: 238  / 255, blue: 238  / 255)
    }
    
    static var secondaryText: Color {
        .init(red: 208 / 255, green: 208 / 255, blue: 208 / 255)
    }
    
    static var tertiaryText: Color {
        .init(red: 188 / 255, green: 188 / 255, blue: 188 / 255)
    }
    
    // MARK: - Other
    static var otherRed: Color {
        .init(red: 165 / 255, green: 4 / 255, blue: 4 / 255)
    }
    
    static var primaryAccent: Color {
        .otherRed
    }
    
    static var secondaryAccent: Color {
        .otherRed
    }
    
    static var onBackground: Color {
        Color.white.opacity(0.1)
    }
}

// MARK: - Preview
#Preview(traits: .standardPreviewModifier) {
    return ScrollView {
        VStack(spacing: 10) {
            colorItem(name: "Primary Background", color: .primaryBackground)
            colorItem(name: "Secondary Background", color: .secondaryBackground)
            colorItem(name: "Tertiary Background", color: .tertiaryBackground)
            colorItem(name: "Quad Background", color: .quadBackground)
            colorItem(name: "Primary Text", color: .primaryText)
            colorItem(name: "Secondary Text", color: .secondaryText)
            colorItem(name: "Tertiary Text", color: .tertiaryText)
            colorItem(name: "Other Red", color: .otherRed)
            colorItem(name: "Primary Accent", color: .primaryAccent)
            colorItem(name: "Secondary Accent", color: .secondaryAccent)
            colorItem(name: "On Background", color: .onBackground)
        }
        .padding()
    }
    
    func colorItem(name: String, color: Color) -> some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 50, height: 50)
            Text(name)
                .font(.headline)
                .foregroundColor(.primaryText)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.secondaryBackground)
        .cornerRadius(10)
    }
}
