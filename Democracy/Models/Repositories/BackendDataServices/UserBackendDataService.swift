//
//  UserBackendDataService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/11/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

@StorageActor
protocol UserBackendDataService {
    func createUser(userName: Username, password: Password, email: Email) async throws -> User
    func updatePhone(phone: PhoneNumber, password: Password) async throws -> User
    func fetchSignedInUser() async throws -> User
    func getUsernameAvailable(username: Username) async throws -> Bool
    func getPhoneIsAvailable(_ phone: PhoneNumber) async throws -> Bool
    func getEmailAvailable(_ email: Email) async throws -> Bool
    
    nonisolated init()
}

struct UserBackendDataServiceDefault: UserBackendDataService {
    @Injected(\.appwriteService) var appwriteService
    
    func createUser(userName: Username, password: Password, email: Email) async throws -> User {
        try await appwriteService.createUser(userName: userName, password: password, email: email)
    }
    
    func updatePhone(phone: PhoneNumber, password: Password) async throws -> User {
        try await appwriteService.updatePhone(phone: phone, password: password)
    }
    
    func fetchSignedInUser() async throws -> User {
        try await appwriteService.getCurrentLoggedInUser()
    }
    
    func getUsernameAvailable(username: Username) async throws -> Bool {
        try await appwriteService.callCustomFunction(request: UniqueAccountFieldRequest(field: .username(username))).isAvailable
    }
    
    func getPhoneIsAvailable(_ phone: PhoneNumber) async throws -> Bool {
        try await appwriteService.callCustomFunction(request: UniqueAccountFieldRequest(field: .phone(phone))).isAvailable
    }
    
    func getEmailAvailable(_ email: Email) async throws -> Bool {
        try await appwriteService.callCustomFunction(request: UniqueAccountFieldRequest(field: .email(email))).isAvailable
    }
}
