//
//  UpdatesTabPath.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/31/23.
//

import Navigator
import SwiftUI

enum UpdatesDestination {
    case one
}

extension UpdatesDestination: NavigationDestination {
    var view: some View {
        switch self {
        case .one:
            EmptyView() // TODO: ...
        }
    }
}
