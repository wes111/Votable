//
//  DynamicHeightSheetModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/17/24.
//

import SwiftUI

public struct DynamicHeightSheetModifier<SheetContent: View>: ViewModifier {
    @Environment(\.theme) var theme: Theme
    @State private var height: CGFloat = .zero
    @Binding var isShowingSheet: Bool
    
    private let sheetContent: () -> SheetContent
    
    public init(isShowingSheet: Binding<Bool>, @ViewBuilder sheetContent: @escaping () -> SheetContent) {
        self._isShowingSheet = isShowingSheet
        self.sheetContent = sheetContent
    }
    
    public func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isShowingSheet) {
                ZStack {
                    theme.primaryColorScheme.secondaryBackground.ignoresSafeArea(.all)
                    
                    sheetContent()
                        .overlay {
                            GeometryReader { proxy in
                                Color.clear
                                    .task(id: proxy.size.height) {
                                        withAnimation {
                                            $height.wrappedValue = max(proxy.size.height, 0)
                                        }
                                    }
                            }
                        }
                        .presentationDetents([.height(height)])
                }
            }
    }
}

// MARK: - View Extension
extension View {
    func dynamicHeightSheet<SheetContent>(
        isShowingSheet: Binding<Bool>,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) -> some View where SheetContent: View {
        self
            .modifier(DynamicHeightSheetModifier(isShowingSheet: isShowingSheet, sheetContent: sheetContent))
    }
    
    func dynamicHeightSheet<SheetContent, Item: Sendable>(
        item: Binding<Item?>,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) -> some View where Item: Identifiable, SheetContent: View {
        self
            .modifier(DynamicHeightSheetModifier(
                isShowingSheet: item.mappedToBool(),
                sheetContent: sheetContent)
            )
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var showSheet: Bool = false
    @Previewable @Environment(\.theme) var theme: Theme
    
    ZStack {
        theme.primaryColorScheme.primaryBackground.ignoresSafeArea()
        
        Button {
            showSheet = true
        } label: {
            Text("Press Me!")
        }
        .dynamicHeightSheet(isShowingSheet: $showSheet) {
            VStack(spacing: theme.sizeConstants.elementSpacing) {
                Text("Hello")
                Text("World!")
            }
            .padding(theme.sizeConstants.screenPadding)
            .foregroundStyle(theme.primaryColorScheme.primaryText)
        }
    }
}
