//
//  Binding+Extension.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/17/24.
//

import SwiftUI

public extension Binding where Value == Bool {
    init<Wrapped: Sendable>(bindingOptional: Binding<Wrapped?>) {
        self.init {
            bindingOptional.wrappedValue != nil
        } set: { newValue in
            guard newValue == false else {
                return
            }
            bindingOptional.wrappedValue = nil
        }
    }
}

public extension Binding {
    func mappedToBool<Wrapped: Sendable>() -> Binding<Bool> where Value == Wrapped? {
        Binding<Bool>(bindingOptional: self)
    }
}
