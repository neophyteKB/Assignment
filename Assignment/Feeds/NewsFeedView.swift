//
//  NewsFeedView.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//

import SwiftUI

struct NewsFeedView: View {
    
    @StateObject private var viewModel = NewsFeedViewModel()
    
    var body: some View {
        NavigationView {
            feedsView
                .navigationTitle("News Reader")
        }
        .showLoader($viewModel.showLoader)
        .task {
            viewModel.fetchArticles()
        }
    }
    
    private var feedsView: some View {
        List(viewModel.articles, id: \.articleId) { article in
            FeedCardView(
                icon: article.sourceIcon,
                title: article.title,
                description: article.description,
                sourceUrl: article.sourceUrl
            )
        }
        .listStyle(.plain)
    }
}

#Preview {
    NewsFeedView()
}
