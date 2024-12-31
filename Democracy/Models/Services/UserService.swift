//
//  UserService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/23/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

// This should probably be called Account service, and then user service would fetch other users.
@StorageActor
protocol UserService: Sendable {
    func setup() async throws
    func createUser(userName: Username, password: Password, email: Email) async throws -> User
    func updatePhone(phone: PhoneNumber, password: Password) async throws -> User
    func fetchSignedInUser() async throws -> User
    func getUsernameAvailable(username: Username) async throws -> Bool
    func getPhoneIsAvailable(_ phone: PhoneNumber) async throws -> Bool
    func getEmailAvailable(_ email: Email) async throws -> Bool
    
    nonisolated init()
}

struct UserServiceDefault: UserService, UserDefaultsStorable {
    @Injected(\.userBackendDataService) private var userBackendDataService
    @Injected(\.userAsyncStreamManager) private var userStreamManager
    
    typealias Object = User
    
    func setup() throws {
        if let user = try getObject() {
            userStreamManager.yield(user)
        }
    }
    
    func createUser(userName: Username, password: Password, email: Email) async throws -> User {
        let user = try await userBackendDataService.createUser(userName: userName, password: password, email: email)
        try didUpdateUser(user)
        return user
    }
    
    func updatePhone(phone: PhoneNumber, password: Password) async throws -> User {
        let user = try await userBackendDataService.updatePhone(phone: phone, password: password)
        try didUpdateUser(user)
        return user
    }
    
    func fetchSignedInUser() async throws -> User { // Need to find out what error is thrown when no signed in user, and handle appropriately.
        let user = try await userBackendDataService.fetchSignedInUser()
        try didUpdateUser(user)
        return user
    }
    
    func getUsernameAvailable(username: Username) async throws -> Bool {
        try await userBackendDataService.getUsernameAvailable(username: username)
    }
    
    func getPhoneIsAvailable(_ phone: PhoneNumber) async throws -> Bool {
        try await userBackendDataService.getPhoneIsAvailable(phone)
    }
    
    func getEmailAvailable(_ email: Email) async throws -> Bool {
        try await userBackendDataService.getEmailAvailable(email)
    }
    
    private func didUpdateUser(_ user: User?) throws {
        if let user {
            try saveObject(user)
        } else {
            try deleteObject()
        }
        userStreamManager.yield(user)
    }
}
