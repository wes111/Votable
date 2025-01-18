//
//  SuccessViewModelMock.swift
//  SharedSwiftUI
//
//  Created by Wesley Luntsford on 1/2/25.
//

import Foundation
import SharedSwift

public final class SuccessViewModelMock: SuccessViewModel {
    public let primaryText: String = ""
    public let secondaryText: String = ""
    public let imageType: SystemImage = .arrowRight
    public let primaryButtonInfo: ButtonInfo = .preview
    public let secondaryButtonInfo: ButtonInfo? = nil
    public var closeAction: () -> Void = {}
    
    public init() {}
}
