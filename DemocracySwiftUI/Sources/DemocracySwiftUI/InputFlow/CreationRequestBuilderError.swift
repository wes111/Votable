//
//  CreationRequestBuilderError.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/15/24.
//

import SharedSwiftUI
import Foundation

@MainActor
public enum CreationRequestBuilderError<T: UserInputFlow>: Error {
    case invalidInput(T)
    case itemAlreadyAdded(T)
    case valueUnavailable(T)
    case itemMissing(T)
    case linkMissingMetadata
    case defaultError
    
    public var alert: NewAlertModel {
        switch self {
        case .invalidInput(let flow):
                .init(
                    title: "Invalid \(flow.title)",
                    description: "\(flow.title) is invalid."
                )
            
        case .itemAlreadyAdded(let flow):
                .init(
                    title: "\(flow.title) Already Added",
                    description: "This \(flow.title) has already been added."
                )
            
        case .valueUnavailable(let flow):
                .init(
                    title: "\(flow.title) Unavailable",
                    description: "Please enter a different \(flow.title) to continue."
                )
            
        case .itemMissing(let flow):
                .init(
                    title: "Missing \(flow.title)",
                    description: "\(T.flowTitle)s must have at least 1 \(flow.title)."
                )
            
        case .linkMissingMetadata:
                .init(
                    title: "Unable to Verify Link",
                    description: "Ensure the link you provided is valid or try again later."
                )
            
        case .defaultError:
                .init(
                    title: "Create \(T.flowTitle) Error",
                    description: "Please try again later."
                )
        }
    }
}

