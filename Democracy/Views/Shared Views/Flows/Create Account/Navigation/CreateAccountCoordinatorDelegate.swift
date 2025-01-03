//
//  OnboardingCoordinatorDelegate.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/22/23.
//

import DemocracySwiftUI
import Foundation

@MainActor
protocol CreateAccountCoordinatorDelegate: FlowCoordinatorDelegate {
    func goToSuccess()
}
