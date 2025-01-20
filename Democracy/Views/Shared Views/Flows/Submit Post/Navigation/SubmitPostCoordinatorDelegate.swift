//
//  SubmitPostCoordinatorDelegate.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import DemocracySwiftUI
import Foundation

@MainActor
protocol SubmitPostCoordinatorDelegate: FlowCoordinatorDelegate {
    func goToSuccess()
}
