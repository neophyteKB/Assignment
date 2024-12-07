//
//  FeedCardView.swift
//  Assignment
//
//  Created by Kamal Kishor on 03/12/24.
//

import SwiftUI

struct FeedCardView: View {
    let icon: String?
    let title: String
    let description: String?
    let sourceUrl: String?
    
    var body: some View {
        HStack(spacing: 8.0) {
            iconView
            feedsTitleView
        }
        .padding(.horizontal, 8.0)
    }
    
    private var feedsTitleView: some View {
        VStack(alignment: .leading, spacing: 2.0) {
            titleView
            descriptionView
            sourceUrlView
        }
    }
    
    private var titleView: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .lineLimit(description == nil ? 4 : 2)
    }
    
    @ViewBuilder
    private var descriptionView: some View {
        if let description {
            Text(description)
                .font(.body)
                .lineLimit(2)
        }
    }
    
    private var iconView: some View {
        asyncImageView
            .frame(width: 60.0, height: 60.0)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8.0)
            .shadow(radius: 1.0)
    }
    
    @ViewBuilder
    private var sourceUrlView: some View {
        if let sourceUrl {
            Button(action: {
                guard let url = URL(string: sourceUrl) else {
                    return
                }
                UIApplication.shared.open(url)
            }, label: {
                Text(sourceUrl)
                    .font(.caption)
                    .foregroundStyle(.primary)
                    .underline(true, color: .primary)
            })
        }
    }
    
    @ViewBuilder
    private var asyncImageView: some View {
        if let icon {
            AsyncImageView(
                url: icon,
                placeholder: { placeholderIcon }
            )
        } else {
            placeholderIcon
        }
    }
    
    private var placeholderIcon: some View {
        Image(systemName: "bird")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 30.0, height: 30.0)
    }
}

#Preview("Feed Card") {
    FeedCardView(
        icon: "https://i.bytvi.com/domain_icons/dentonrc.jpg",
        title: "Signing day momentum?",
        description: "North Texas is headed into a key point in its efforts to build for the future with momentum on its side.",
        sourceUrl: "https://dentonrc.com"
    )
}
