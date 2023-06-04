import SwiftUI
import SafariServices

public struct SafariView: View {
    @Binding var url: URL?
    var entersReaderIfAvailable: Bool = false
    
    public var body: some View {
        SafariViewRepresentable(url: $url, enterReader: entersReaderIfAvailable)
            .navigationBarHidden(true)
            .ignoresSafeArea()
    }
}

fileprivate struct SafariViewRepresentable: UIViewControllerRepresentable {
    @Binding var url: URL?
    let enterReader: Bool
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = enterReader
        
        let vc = SFSafariViewController(url: url!, configuration: config)
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ controller: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariViewRepresentable>) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension SafariViewRepresentable {
    fileprivate final class Coordinator: NSObject, SFSafariViewControllerDelegate {
        let parent: SafariViewRepresentable
        
        init(_ parent: SafariViewRepresentable) {
            self.parent = parent
        }
        
        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            parent.url = nil
        }
    }
}
