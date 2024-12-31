//
//  ValidatableInput+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/16/24.
//

import Foundation
import SharedResourcesClientAndServer

extension Email {
    var appwriteEmail: String {
        "\"\(value)\""
    }
}

extension Username {
    var appwriteString: String {
        value
    }
}

extension PhoneNumber {
    var appwriteString: String {
        "+1\(value)"
    }
}
