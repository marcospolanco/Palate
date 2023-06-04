//
//  Carousel.swift
//  Palate
//
//  Created by Marco’s Polanco on 6/4/23.
//

import Foundation



import SwiftUI

struct ImageCarouselView: View {
    let imageUrls: [URL]
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(imageUrls, id: \.self) { imageUrl in
                    AsyncImage(url: imageUrl, placeholder: {
                        ProgressView()
                    }, image: { image in
                        Image(uiImage: image)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 200, height: 300)
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: imageWidth, height: imageHeight)
                    })
                }
            }
            .padding()    .frame(maxHeight: 200).aspectRatio(contentMode: .fit)

        }
    }
}



struct CarouselView: View {
    let imageUrls: [URL] = [
        URL(string: "https://cdn.zappy.app/74583ec9e8aeef5b56f50b22be6e35d2.png")!,
        URL(string: "https://cdn.zappy.app/bfb55721b94c43c742ab1e7d84e5271b.png")!
//        URL(string: "https://image.thum.io/get/https://www.brookings.edu/research/how-artificial-intelligence-is-transforming-the-world/")!,
//        URL(string: "https://image.thum.io/get/https://medium.com/@ageitgey/machine-learning-is-fun-part-3-deep-learning-and-convolutional-neural-networks-f40359318721")!
    ] // Replace with your image URLs
    let imageWidth: CGFloat = 50
    let imageHeight: CGFloat = 50
    
    var body: some View {
            ImageCarouselView(imageUrls: imageUrls, imageWidth: imageWidth, imageHeight: imageHeight)    .frame(maxHeight: 100)

    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}

struct AsyncImage<Placeholder: View>: View {
    @StateObject private var imageLoader: ImageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    
    init(url: URL, @ViewBuilder placeholder: () -> Placeholder, @ViewBuilder image: @escaping (UIImage) -> Image) {
        self.placeholder = placeholder()
        self.image = image
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        content
            .onAppear(perform: imageLoader.load)
    }
    
    private var content: some View {
        Group {
            if let loadedImage = imageLoader.image {
                image(loadedImage)
            } else {
                placeholder
            }
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func load() {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
