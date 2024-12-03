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
                .task {
                    viewModel.fetchArticles()
                }
        }
    }
    
    private var feedsView: some View {
        List(viewModel.articles, id: \.articleId) { article in
            Text(article.title)
        }
    }
}

#Preview {
    NewsFeedView()
}
