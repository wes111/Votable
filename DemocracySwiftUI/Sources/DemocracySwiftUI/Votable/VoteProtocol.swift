//
//  VoteProtocol.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 1/1/25.
//

import Foundation
import SharedResourcesClientAndServer

// A vote on a `Votable` object.
public protocol VoteProtocol {
    var id: String { get }
    var creationDate: Date { get }
    var itemId: String { get } // The id of the `Votable` object.
    var userId: String { get }
    var vote: VoteType? { get set }
    
    static func createTempVote() -> Self
}
