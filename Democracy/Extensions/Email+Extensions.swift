//
//  Email+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/2/25.
//

import Foundation
import SharedResourcesClientAndServer

extension Email {
    var appwriteEmail: String {
        "\"\(value)\""
    }
}
