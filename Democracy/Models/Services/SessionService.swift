//
//  SessionService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/12/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

@StorageActor
protocol SessionService: Sendable {
    func setup() async throws
    func login(email: Email, password: Password) async throws -> (Session, User)
    func logout(sessionId: String) async throws
    func acceptTerms(accountBuilder: AccountCreationRequestBuilder) async throws -> (Session, User)
    
    nonisolated init()
}

struct SessionServiceDefault: SessionService, UserDefaultsStorable {
    typealias Object = Session
    
    @Injected(\.sessionBackendDataService) private var sessionBackendDataService
    @Injected(\.sessionAsyncStreamManager) private var sessionStreamManager
    @Injected(\.userService) private var userService
    
    func setup() async throws {
        if let session = try getObject() {
            sessionStreamManager.yield(session)
        }
        try await refreshSession()
    }
    
    func login(email: Email, password: Password) async throws -> (Session, User) {
        let session = try await sessionBackendDataService.createSession(email: email, password: password)
        try didUpdateSession(session)
        let user = try await userService.fetchSignedInUser()
        return (session, user)
    }
    
    func logout(sessionId: String) async throws {
        try await sessionBackendDataService.deleteSession(sessionId: sessionId)
        try didUpdateSession(nil)
        _ = try await userService.fetchSignedInUser()
    }
    
    func acceptTerms(accountBuilder: AccountCreationRequestBuilder) async throws -> (Session, User) {
        let request = try await accountBuilder.build()
        _ = try await userService.createUser(userName: request.username, password: request.password, email: request.email)
        if let phone = request.phoneNumber {
            _ = try await userService.updatePhone(phone: phone, password: request.password)
        }
        return try await login(email: request.email, password: request.password)
    }
    
    private func didUpdateSession(_ session: Session?) throws {
        if let session {
            try saveObject(session)
        } else {
            try deleteObject()
        }
        sessionStreamManager.yield(session)
    }
    
    private func refreshSession() async throws {
        do {
            let session = try await sessionBackendDataService.fetchCurrentSession()
            try didUpdateSession(session)
            try await deleteSessionIfNearExpiration(session)
        } catch {
            if error.localizedDescription == AppwriteError.noSession.rawValue {
                try didUpdateSession(nil)
            } else {
                throw error
            }
        }
    }
    
    private func deleteSessionIfNearExpiration(_ session: Session) async throws {
        if session.expirationDate < Calendar.current.addDaysToNow(dayCount: 3) {
            try await logout(sessionId: session.id)
        }
    }
}
