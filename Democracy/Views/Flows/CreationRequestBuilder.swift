//
//  CreationRequestBuilder.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/24.
//

import Foundation

@MainActor
protocol CreationRequestBuilder {
    associatedtype Flow: UserInputFlow
    typealias BuilderError = CreationRequestBuilderError<Flow>
}

extension CreationRequestBuilder {
    func validateAndCheckAvailability<T>(
        value: String,
        transform: (String) throws -> T,
        availabilityCheck: (T) async throws -> Bool,
        field: Flow
    ) async throws(BuilderError) -> T {
        let validValue: T
        let isAvailable: Bool
        do {
            validValue = try transform(value)
        } catch {
            throw .invalidInput(field)
        }
        
        do {
            isAvailable = try await availabilityCheck(validValue)
        } catch {
            throw .defaultError
        }
        
        guard isAvailable else {
            throw .valueUnavailable(field)
        }
        
        return validValue
    }
    
    func checkDuplicate<T: Equatable>(
        input: T,
        excluding excluded: T? = nil,
        existingItems: [T],
        field: Flow
    ) throws(BuilderError) {
        let filteredItems = existingItems.filter { $0 != excluded }
        guard !filteredItems.contains(input) else {
            throw .itemAlreadyAdded(field)
        }
    }
    
    func validate<T>(
        value: String,
        transform: (String) throws -> T,
        field: Flow
    ) throws(BuilderError) -> T {
        do {
            return try transform(value)
        } catch {
            throw .invalidInput(field)
        }
    }
    
    func addItem<T: Equatable>(
        value: String,
        existingItems: inout [T],
        transform: (String) throws -> T,
        field: Flow
    ) throws(BuilderError) {
        let validItem = try validate(value: value, transform: transform, field: field)
        guard !existingItems.contains(validItem) else {
            throw .itemAlreadyAdded(field)
        }
        existingItems.insert(validItem, at: 0)
    }
    
    func updateItem<T: Equatable>(
        item: T,
        existingItems: inout [T],
        updatedItem: T,
        field: Flow
    ) throws(BuilderError) {
        try checkDuplicate(input: updatedItem, excluding: item, existingItems: existingItems, field: field)
        guard let index = existingItems.firstIndex(of: item) else {
            throw .defaultError
        }
        existingItems[index] = updatedItem
    }
}
