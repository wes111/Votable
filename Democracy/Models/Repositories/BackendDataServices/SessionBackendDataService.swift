//
//  SessionBackendDataService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/12/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

@StorageActor
protocol SessionBackendDataService {
    func createSession(email: Email, password: Password) async throws -> Session
    func deleteSession(sessionId: String) async throws
    func fetchCurrentSession() async throws -> Session
    
    nonisolated init()
}

struct SessionBackedDataServiceDefault: SessionBackendDataService {
    @Injected(\.appwriteService) var appwriteService
    
    func createSession(email: Email, password: Password) async throws -> Session {
        try await appwriteService.createSession(email: email, password: password)
    }
    
    func deleteSession(sessionId: String) async throws {
        try await appwriteService.deleteSession(sessionId: sessionId)
    }
    
    func fetchCurrentSession() async throws -> Session {
        try await appwriteService.getCurrentSession()
    }
}
