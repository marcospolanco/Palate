
import SwiftUI


struct DemoView: View {
    var body: some View {
        ZStack {
            // Background image
            if let url = Bundle.main.url(forResource: "palate_bg", withExtension: "png"),
               let uiImage = UIImage(contentsOfFile: url.path) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
//                ContentView()
            }
        }
    }
}
