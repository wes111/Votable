//
//  UserDefaultsStorableType.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/11/24.
//

import Foundation
import SharedResourcesClientAndServer

protocol UserDefaultsStorableType: Codable {
    static var key: UserDefaultsKey { get }
}

extension User: UserDefaultsStorableType {
    static var key: UserDefaultsKey {
        .user
    }
}

extension Session: UserDefaultsStorableType {
    static var key: UserDefaultsKey {
        .session
    }
}
