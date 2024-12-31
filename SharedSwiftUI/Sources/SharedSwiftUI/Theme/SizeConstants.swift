//
//  SizeConstants.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 12/29/24.
//

import SwiftUI

public struct SizeConstants: Sendable {
    // Element Spacing
    public let extraSmallElementSpacing: CGFloat
    public let smallElementSpacing: CGFloat
    public let elementSpacing: CGFloat
    public let largeElementSpacing: CGFloat
    public let extraLargeElementSpacing: CGFloat
    
    // Section Spacing
    public let sectionSpacing: CGFloat
    public let sectionIndent: CGFloat
    
    // Padding between element and element's border
    public let innerBorder: CGFloat
    public let smallInnerBorder: CGFloat
    public let extraSmallInnerBorder: CGFloat
    
    // Text (field or editor) padding
    public let textFieldPadding: CGFloat
    public let textEditorPadding: CGFloat
    public let smallTextInputPadding: CGFloat
    
    // Animation Constants
    public let animationLength: Double
    
    // Scaling
    public let minTextScale: Double
    
    // Other standard values
    public let cornerRadius: CGFloat
    public let screenPadding: CGFloat
    public let partialSheetTopPadding: CGFloat
    public let thinBorderWidth: CGFloat // For smaller elements like tags.
    public let borderWidth: CGFloat
    public let dimmingBrightness: Double
    
    // Buttons
    public let smallButtonRadius: CGFloat
    
    // Sheets
    public let sheetBottomPadding: CGFloat
    
    public let scrollViewTopContentMargin: CGFloat
    
    public init(
        extraSmallElementSpacing: CGFloat,
        smallElementSpacing: CGFloat,
        elementSpacing: CGFloat,
        largeElementSpacing: CGFloat,
        extraLargeElementSpacing: CGFloat,
        sectionSpacing: CGFloat,
        sectionIndent: CGFloat,
        innerBorder: CGFloat,
        smallInnerBorder: CGFloat,
        extraSmallInnerBorder: CGFloat,
        textFieldPadding: CGFloat,
        textEditorPadding: CGFloat,
        smallTextInputPadding: CGFloat,
        animationLength: Double,
        minTextScale: Double,
        cornerRadius: CGFloat,
        screenPadding: CGFloat,
        partialSheetTopPadding: CGFloat,
        thinBorderWidth: CGFloat,
        borderWidth: CGFloat,
        dimmingBrightness: Double,
        smallButtonRadius: CGFloat,
        sheetBottomPadding: CGFloat,
        scrollViewTopContentMargin: CGFloat
    ) {
        self.extraSmallElementSpacing = extraSmallElementSpacing
        self.smallElementSpacing = smallElementSpacing
        self.elementSpacing = elementSpacing
        self.largeElementSpacing = largeElementSpacing
        self.extraLargeElementSpacing = extraLargeElementSpacing
        self.sectionSpacing = sectionSpacing
        self.sectionIndent = sectionIndent
        self.innerBorder = innerBorder
        self.smallInnerBorder = smallInnerBorder
        self.extraSmallInnerBorder = extraSmallInnerBorder
        self.textFieldPadding = textFieldPadding
        self.textEditorPadding = textEditorPadding
        self.smallTextInputPadding = smallTextInputPadding
        self.animationLength = animationLength
        self.minTextScale = minTextScale
        self.cornerRadius = cornerRadius
        self.screenPadding = screenPadding
        self.partialSheetTopPadding = partialSheetTopPadding
        self.thinBorderWidth = thinBorderWidth
        self.borderWidth = borderWidth
        self.dimmingBrightness = dimmingBrightness
        self.smallButtonRadius = smallButtonRadius
        self.sheetBottomPadding = sheetBottomPadding
        self.scrollViewTopContentMargin = scrollViewTopContentMargin
    }
}
