//
//  AsyncStreamable.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/21/24.
//

/// A protocol for objects that emit asynchronous streams of values using `AsyncStream`.
///
/// This is useful for managing streams of data where multiple subscribers may need to observe updates.
@StorageActor
protocol AsyncStreamable: AnyObject {
    associatedtype Object: Sendable
    
    func stream() -> AsyncStream<Object?>
    var currentValue: Object? { get set }
}
