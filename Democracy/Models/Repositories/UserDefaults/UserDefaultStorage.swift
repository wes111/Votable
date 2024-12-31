//
//  UserDefaultsService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/12/23.
//

import Foundation

protocol UserDefaultsStorable {
    associatedtype Object: UserDefaultsStorableType
    
    func saveObject(_ object: Object) throws
    func deleteObject() throws
}

extension UserDefaultsStorable {
    
    func saveObject(_ object: Object) throws {
        let encoded = try JSONEncoder().encode(object)
        defaults.set(encoded, forKey: Object.key.rawValue)
    }
    
    func deleteObject() throws {
        defaults.removeObject(forKey: Object.key.rawValue)
    }
    
    func getObject() throws -> Object? {
        if let data = defaults.object(forKey: Object.key.rawValue) as? Data {
            try JSONDecoder().decode(Object.self, from: data)
        } else {
            nil
        }
    }
    
    private var defaults: UserDefaults {
        UserDefaults.standard
    }
}
