//
//  AsyncStreamManaging.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/21/24.
//

import Foundation

/// The `AsyncStreamManaging` protocol extends the functionality of both `AsyncStreamYielding` and `AsyncStreamable`,
/// allowing conforming types to manage a collection of `AsyncStream` continuations. It provides mechanisms for subscribing
/// to streams, yielding new values to those streams, and handling the termination of each stream. This is particularly useful
/// when managing concurrent or asynchronous data flows where multiple consumers need to receive updates.
///
/// ## Responsibilities:
/// - Manage a list of subscribers (`continuations`) using `AsyncStream.Continuation`.
/// - Provide a mechanism for yielding new values to all active streams.
/// - Handle the cancellation and termination of continuations.
// https://stackoverflow.com/questions/75855208/thread-safe-combine-publisher-to-asyncstream
@StorageActor
protocol AsyncStreamManaging: AsyncStreamYielding, AsyncStreamable {
    var continuations: [UUID: AsyncStream<Object?>.Continuation] { get set }
    func handleContinuationTermination(_ continuation: AsyncStream<Self.Object?>.Continuation, id: UUID)
}

extension AsyncStreamManaging {
    
    func stream() -> AsyncStream<Object?> {
        AsyncStream { continuation in
            let id = UUID()
            continuations[id] = continuation
            handleContinuationTermination(continuation, id: id)
        }
    }

    func yield(_ values: Object?) {
        for continuation in continuations.values {
            continuation.yield(values)
        }
        currentValue = values
    }
    
    func cancel(_ id: UUID) {
        continuations[id] = nil
    }
}
