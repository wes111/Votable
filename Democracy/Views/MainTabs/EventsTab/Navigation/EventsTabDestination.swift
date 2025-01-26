//
//  EventsTabPath.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/31/23.
//

import Navigator
import SwiftUI

enum EventsTabDestination {
    case one
}

extension EventsTabDestination: NavigationDestination {
    var view: some View {
        switch self {
        case .one:
            EmptyView() // TODO: ...
        }
    }
}
