//
//  ViewConstants.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation

// TODO: update to 4, 8, 12, 16, 20, 24, 28, 32, etc...
enum ViewConstants {
    // Element Spacing
    static let extraSmallElementSpacing: CGFloat = 4
    static let smallElementSpacing: CGFloat = 8
    static let elementSpacing: CGFloat = 12
    static let largeElementSpacing: CGFloat = 16
    static let extraLargeElementSpacing: CGFloat = 20
    
    // Section Spacing
    static let sectionSpacing: CGFloat = 15
    static let sectionIndent: CGFloat = 20
    
    // Padding between element and element's border
    static let innerBorder: CGFloat = 16
    static let smallInnerBorder: CGFloat = 8
    static let extraSmallInnerBorder: CGFloat = 4
    
    // Text (field or editor) padding
    static let textFieldPadding: CGFloat = 15
    static let textEditorPadding: CGFloat = 17.5
    static let smallTextInputPadding: CGFloat = 5
    
    // Animation Constants
    static let animationLength = 0.3
    
    // Scaling
    static let minTextScale = 0.75
    
    // Other standard values
    static let cornerRadius: CGFloat = 10
    static let screenPadding: CGFloat = 16
    static let partialSheetTopPadding: CGFloat = 20
    static let thinBorderWidth: CGFloat = 2 // For smaller elements like tags.
    static let borderWidth: CGFloat = 3
    static let dimmingBrightness = -0.1
    
    // Buttons
    static let smallButtonRadius: CGFloat = 35
    
    // Sheets
    static let sheetBottomPadding: CGFloat = 32
    
    static let scrollViewTopContentMargin: CGFloat = 16
}
