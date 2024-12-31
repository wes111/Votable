//
//  Session.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/23/24.
//

import Appwrite
import Foundation
import SharedResourcesClientAndServer

extension Appwrite.Session {
    
    func toSession() -> SharedResourcesClientAndServer.Session {
        let formatter = ISO8601DateFormatter.sharedWithFractionalSeconds
        
        return .init(
            id: id,
            createdAt: formatter.date(from: createdAt),
            userId: userId,
            expirationDate: formatter.date(from: expire) ?? .now,
            provider: provider,
            providerUid: providerUid,
            providerAccessToken: providerAccessToken,
            providerAccessTokenExpirationDate: formatter.date(from: providerAccessTokenExpiry),
            providerRefreshToken: providerRefreshToken,
            countryCode: countryCode,
            current: current
        )
    }
}
