//
//  AsyncStreamManager.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/21/24.
//

import Foundation

/// A class that manages asynchronous streams, allowing values to be emitted and observed via `AsyncStream`.
///
/// The `AsyncStreamManager` is responsible for managing multiple subscribers through `AsyncStream` continuations.
/// Subscribers can observe changes to a stream of values of type `T`. The manager ensures that all subscribers
/// are notified whenever a new value is yielded, and it handles the lifecycle of each continuation, including its termination.
class AsyncStreamManager<T: Sendable>: AsyncStreamManaging {
    var currentValue: T?
    var continuations: [UUID: AsyncStream<T?>.Continuation] = [:]
    
    func handleContinuationTermination(_ continuation: AsyncStream<T?>.Continuation, id: UUID) {
        continuation.onTermination = { _ in
            Task {
                await self.cancel(id)
            }
        }
    }
}
