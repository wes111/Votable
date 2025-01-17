//
//  SuccessViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/24.
//

import Foundation

@MainActor
public protocol SuccessViewModel: Hashable {
    var primaryText: String { get }
    var secondaryText: String { get }
    var imageType: SystemImage { get }
    var primaryButtonInfo: ButtonInfo { get }
    var secondaryButtonInfo: ButtonInfo? { get }
    var closeAction: () -> Void { get }
}
