//
//  SystemImage.swift
//  SharedResourcesClientAndServer
//
//  Created by Wesley Luntsford on 10/23/24.
//

import Foundation
import SharedSwiftUI
import SwiftUI

// Image assets
enum CustomImage: String {
    case bmw = "BMW"
}

// Any SystemImage or Image Asset
enum AppImage {
    case systemImage(SystemImage)
    case customImage(CustomImage)
    
    public var image: Image {
        switch self {
        case .systemImage(let systemImage):
            Image(systemName: systemImage.rawValue)
        case .customImage(let customImage):
            Image(customImage.rawValue)
        }
    }
}
