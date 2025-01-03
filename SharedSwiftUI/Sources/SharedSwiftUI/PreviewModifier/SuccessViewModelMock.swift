//
//  SuccessViewModelMock.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 1/2/25.
//

import Foundation
import SharedSwift

final class SuccessViewModelMock: SuccessViewModel {
    let primaryText: String = ""
    let secondaryText: String = ""
    let imageType: SystemImage = .arrowRight
    let primaryButtonInfo: ButtonInfo = .preview
    let secondaryButtonInfo: ButtonInfo? = nil
    var closeAction: () -> Void = {}
    
    init() {}
}
