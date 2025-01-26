//
//  EventsTabMainView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct EventsTabMainView: View {
    
    @State private var viewModel = EventsTabMainViewModel()
    
    var body: some View {
        Text("Events")
    }
}

// MARK: - Preview
#Preview {
    EventsTabMainView()
}
