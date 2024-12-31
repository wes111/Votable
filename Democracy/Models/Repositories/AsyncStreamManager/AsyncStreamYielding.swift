//
//  AsyncStreamYielding.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/21/24.
//

/// A protocol for emitting values to an asynchronous stream.
///
/// `AsyncStreamYielding` provides a method to yield values to subscribers asynchronously. The associated type `Object` must
/// conform to `Sendable` to ensure thread-safe value transmission across concurrency boundaries.
@StorageActor
protocol AsyncStreamYielding: AnyObject {
    associatedtype Object: Sendable
    
    func yield(_ values: Object?)
}
