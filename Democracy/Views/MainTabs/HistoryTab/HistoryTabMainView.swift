//
//  HistoryTabMainView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct HistoryTabMainView: View {
    
    @State private var viewModel = HistoryTabMainViewModel()
    
    init() {}
    
    var body: some View {
        Text("History")
    }
}

// MARK: - Preview
#Preview {
    HistoryTabMainView()
}
