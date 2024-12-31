//
//  SizeConstants+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/29/24.
//

import SharedSwiftUI

extension SizeConstants {
    @MainActor static let primary: SizeConstants = {
        .init(
            extraSmallElementSpacing: 4,
            smallElementSpacing: 8,
            elementSpacing: 12,
            largeElementSpacing: 16,
            extraLargeElementSpacing: 20,
            sectionSpacing: 16,
            sectionIndent: 20,
            innerBorder: 16,
            smallInnerBorder: 8,
            extraSmallInnerBorder: 4,
            textFieldPadding: 15,
            textEditorPadding: 17.5,
            smallTextInputPadding: 5,
            animationLength: 0.3,
            minTextScale: 0.75,
            cornerRadius: 10,
            screenPadding: 16,
            partialSheetTopPadding: 20,
            thinBorderWidth: 2,
            borderWidth: 3,
            dimmingBrightness: -0.1,
            smallButtonRadius: 35,
            sheetBottomPadding: 32,
            scrollViewTopContentMargin: 16
        )
    }()
}
