//
//  SessionServiceMock.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/13/24.
//

import Foundation
import SharedResourcesClientAndServer

struct SessionServiceMock: SessionService {

    
    func setup() async throws { }
    
    func login(email: Email, password: Password) async throws -> (Session, User) {
        (.preview, .preview)
    }
    
    func logout(sessionId: String) async throws { }
    
    func acceptTerms(accountBuilder: AccountCreationRequestBuilder) async throws -> (Session, User) {
        (.preview, .preview)
    }
}
