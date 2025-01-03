//
//  WebView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/13/23.
//

import Foundation
import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    @Binding var url: URL
    
    public init(url: Binding<URL>) {
        self._url = url
    }
 
    public func makeUIView(context: Context) -> WKWebView {
        let wKWebView = WKWebView()
        return wKWebView
    }
 
    public func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }

}
