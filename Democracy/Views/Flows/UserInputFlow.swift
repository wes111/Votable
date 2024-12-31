//
//  UserInputFlow.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/24.
//

import Foundation

@MainActor
protocol UserInputFlow: Hashable, CaseIterable, Sendable, RawRepresentable where RawValue == Int {
    var progress: Int { get }
    var title: String { get }
    var subtitle: String { get }
    var next: Self? { get }
    var previous: Self? { get }
    var canGoBack: Bool { get }
    
    static var flowTitle: String { get }
}

extension UserInputFlow {
    var next: Self? {
        Self(rawValue: self.rawValue + 1)
    }

    var previous: Self? {
        Self(rawValue: self.rawValue - 1)
    }
    
    var progress: Int {
        self.rawValue
    }
}
