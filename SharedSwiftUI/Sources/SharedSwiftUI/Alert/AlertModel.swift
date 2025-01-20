//
//  OnboardingAlert.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/15/23.
//

import Foundation

public protocol AlertModelProtocol {
    var title: String { get }
    var description: String { get }
    
    func toNewAlertModel() -> NewAlertModel
}

public extension AlertModelProtocol {
    func toNewAlertModel() -> NewAlertModel {
        .init(title: title, description: description)
    }
}

public struct NewAlertModel: Identifiable, Sendable {
    public let title: String
    public let description: String
    
    public init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    public var id: String {
        title
    }
    
    public static let genericAlert = Self.init(
        title: "Error",
        description: "An error occurred, please try again later."
    )
}
