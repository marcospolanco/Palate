//
//  WebSelector.swift
//  Palate
//
//  Created by Marco’s Polanco on 6/3/23.
//

import SwiftUI
import WebKit
import SafariServices

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if uiView.canGoBack {
            uiView.goBack()
        } else if uiView.canGoForward {
            uiView.goForward()
        }
    }
}

//struct SafariView: UIViewControllerRepresentable {
//    let url: URL
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
//        return SFSafariViewController(url: url)
//    }
//
//    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
//        // No update needed
//    }
//}
