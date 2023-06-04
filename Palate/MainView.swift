import SwiftUI
import WebKit

struct MainView: View {
    @State var urlString = "https://www.google.com"
    @State private var isShowingBrowserView = false

    var body: some View {
        NavigationView {
            Button(action: {
                self.isShowingBrowserView = true
            }) {
                Text("Open BrowserView")
            }
            .fullScreenCover(isPresented: $isShowingBrowserView, content: {
                BrowserViewWrapper(isPresented: $isShowingBrowserView, urlString: urlString)
            })
        }
    }
}

var globalWebView: WKWebView? = nil

struct BrowserView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView  {
        let webView = WKWebView()
        globalWebView = webView
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

struct BrowserViewWrapper: View {
    @Binding var isPresented: Bool
    let urlString: String

    var body: some View {
        NavigationView {
            BrowserView(urlString: urlString)
                .navigationBarTitle("Browser View", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            self.isPresented = false
                        }) {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.isPresented = false
                            
                            let currentUrl = globalWebView?.url?.absoluteString ?? "<unknown>"
                            print("currently: \(currentUrl)")
                        }) {
                            Text("Done")
                        }
                    }
                }
        }
    }
}
