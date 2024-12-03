//
//  BookmarksDetailView.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//
import SwiftUI

struct ArticleDetailView: View {
    let article: Article

    var body: some View {
        ScrollView {
            Text(article.content)
                .padding()
        }
        .navigationTitle(article.title)
    }
}

#Preview {
    guard let feed = JsonParser.feeds.first else { return EmptyView() }
    return ArticleDetailView(article: feed)
}
