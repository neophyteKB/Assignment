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
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        BookmarkButton(
                            bookmarkCount: $viewModel.bookmarkCount
                        )
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        CategoryButtonView(
                            selectedCategories: $viewModel.categoryFilter
                        )
                    }
                }
                .onAppear {
                    self.viewModel.fetchBookmaks()
                }
        }
        .showLoader($viewModel.showLoader)
        .task {
            await self.viewModel.fetchArticles()
        }
        .fullScreenCover(isPresented: self.$viewModel.hasError) {
            ErrorView(
                error: self.viewModel.error,
                tryAgain: self.$viewModel.tryAgain
            )
        }
    }
    
    private var feedsView: some View {
        List(viewModel.articles, id: \.articleId) { article in
            NavigationLink {
                destination(article: article)
            } label: {
                cardView(article: article)
            }
        }
        .listStyle(.plain)
        .searchable(text: $viewModel.searchText, prompt: "Search...")
    }
    
    private func cardView(article: Article) -> some View {
        FeedCardView(
            icon: article.sourceIcon,
            title: article.title,
            description: article.description,
            sourceUrl: article.sourceUrl
        )
        .swipeActions(edge: .trailing) {
            Button(
                action: { self.onBookmarkTap(article: article) },
                label: { self.bookmarkIcon(id: article.articleId)
                }
            )
        }
    }
    
    private func destination(article: Article) -> some View {
        DetailsView(
            viewModel: .init(
                title: article.title,
                content: article.content,
                desc: article.description,
                link: article.link,
                source: .init(
                    name: article.sourceName,
                    icon: article.sourceIcon,
                    url: article.sourceUrl
                ),
                dateString: article.pubDate.dateString(for: article.pubDateTZ)
            )
        )
    }
                       
    private func bookmarkIcon(id: String) -> some View {
        let icon = self.viewModel.isBookmarked(for: id) ? "bookmark.fill" : "bookmark"
        let foregroundColor: Color = self.viewModel.isBookmarked(for: id) ? .red : .secondary
        return Image(systemName: icon)
            .tint(foregroundColor)
    }
    
    private func onBookmarkTap(article: Article) {
        self.viewModel.toggleBookmark(article: article)
    }
}

#Preview {
    NewsFeedView()
}
