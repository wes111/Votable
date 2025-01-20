//
//  Votable.swift
//  DemocracySwiftUI
//
//  Created by Wesley Luntsford on 1/1/25.
//

import Foundation

// An object that can be voted on, e.g. a `Comment` or a `Post`.
public protocol Votable: AnyObject {
    associatedtype Vote: VoteProtocol
    
    var id: String { get }
    var userVote: Vote? { get set }
    var upVoteCount: Int { get set }
    var downVoteCount: Int { get set }
}
