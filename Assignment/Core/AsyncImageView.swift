//
//  AsyncImageView.swift
//  Assignment
//
//  Created by Kamal Kishor on 07/12/24.
//

import SwiftUI

struct AsyncImageView<ContentView: View>: View {
    @StateObject private var loader: AsyncImageLoader
    @ViewBuilder private var placeholder: ContentView

    init(
        url: String,
        @ViewBuilder placeholder: () -> ContentView
    ) {
        _loader = StateObject(
            wrappedValue: AsyncImageLoader(
                url: URL(string: url)
            )
        )
        self.placeholder = placeholder()
    }

    var body: some View {
        imageView
        .onAppear {
            Task {
                await loader.loadImage()
            }
        }
    }
    
    @ViewBuilder
    private var imageView: some View {
        switch loader.state {
        case .loading:
            ProgressView()
        case .loaded(let image):
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        case .failed:
            placeholder
        }
    }
}

#Preview("Image") {
    AsyncImageView(url: "https://i.bytvi.com/domain_icons/dentonrc.jpg", placeholder: { Image(systemName: "bird")})
}

#Preview("Placeholder") {
    AsyncImageView(url: "https://i.bytvi.com/domain_icons/dentonrc23.jpg", placeholder: { Image(systemName: "bird")})
}
