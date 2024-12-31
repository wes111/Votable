//
//  OnboardingInput.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/22/23.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

struct AccountCreationRequest {
    let username: Username
    let password: Password
    let phoneNumber: PhoneNumber?
    let email: Email
}

@Observable
final class AccountCreationRequestBuilder: CreationRequestBuilder {
    typealias Flow = AccountFlow
    @ObservationIgnored @Injected(\.userService) var userService
    
    private(set) var password: Password?
    private(set) var username: Username?
    private(set) var phone: PhoneNumber?
    private(set) var email: Email?
    
    init() {}
    
    func setUsername(_ username: String) async throws(BuilderError) {
        self.username = try await validateAndCheckAvailability(
            value: username,
            transform: { try Username(value: $0) },
            availabilityCheck: { try await userService.getUsernameAvailable(username: $0) },
            field: .username
        )
    }
    
    func setPassword(_ password: String) throws(BuilderError) {
        self.password = try validate(
            value: password,
            transform: { try Password(value: $0) },
            field: .password
        )
    }
    
    func setEmail(_ email: String) async throws(BuilderError) {
        self.email = try await validateAndCheckAvailability(
            value: email,
            transform: { try Email(value: $0) },
            availabilityCheck: { try await userService.getEmailAvailable($0) },
            field: .email
        )
    }
    
    func setPhone(_ phone: String) async throws(BuilderError) {
        let unformattedPhoneNumber = PhoneFormatter.format(with: "XXXXXXXXXX", phone: phone)
        self.phone = try await validateAndCheckAvailability(
            value: unformattedPhoneNumber,
            transform: { try PhoneNumber(value: $0) },
            availabilityCheck: { try await userService.getPhoneIsAvailable($0) },
            field: .phone
        )
    }
    
    func build() async throws(BuilderError) -> AccountCreationRequest {
        guard let username, let password, let email else {
            throw .defaultError
        }
        return AccountCreationRequest(username: username, password: password, phoneNumber: phone, email: email)
    }
}
