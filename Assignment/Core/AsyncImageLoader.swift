//
//  AsyncImageLoader.swift
//  Assignment
//
//  Created by Kamal Kishor on 07/12/24.
//

import SwiftUI

@MainActor
class AsyncImageLoader: ObservableObject {
    @Published var state: State = .loading
    private let cache = ImageCache()
    private let url: URL?

    init(url: URL?) {
        self.url = url
    }

    func loadImage() async {
        guard let url else {
            self.state = .failed
            return
        }
        if let cachedImage = await cache.image(for: url) {
            self.state = .loaded(cachedImage)
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let downloadedImage = UIImage(data: data) {
                let image = Image(uiImage: downloadedImage)
                self.state = .loaded(image)
                await cache.insert(image, for: url)
            }
        } catch {
            self.state = .failed
        }
    }
    
    enum State {
        case loading
        case loaded(Image)
        case failed
    }
}

private actor ImageCache {
    private var cache: [URL: Image] = [:]

    func image(for url: URL) -> Image? {
        return cache[url]
    }

    func insert(_ image: Image, for url: URL) {
        cache[url] = image
    }
}
