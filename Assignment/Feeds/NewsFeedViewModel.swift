//
//  NewsFeedViewModel.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//

import Combine

@MainActor
final class NewsFeedViewModel: ObservableObject, Sendable {
    @Published var articles: [Article] = []
    @Published var bookmarks: [Bookmark] = []
    @Published var showLoader: Bool = false
    @Published var selectedCategory: NewsCategory = .none
    @Published var hasError: Bool = false
    @Published var bookmarkCount: Int = 0
    var error: Error? = nil

    private let apiManager: NetworkManager
    private var bookmarkIds: [String] = .init()

    init(apiManager: NetworkManager = NetworkManager()) {
        self.showLoader = true
        self.apiManager = apiManager
        self.fetchArticles()
    }

    func fetchArticles() {
        Task {
            do {
                let articles = try await apiManager.fetchArticles()
                self.articles = articles
            } catch {
                hasError = true
                self.error = error
            }
            self.showLoader = false
        }
    }
    
    func isBookmarked(for articleId: String) -> Bool {
        bookmarkIds.contains(where: { $0 == articleId })
    }

    func toggleBookmark(article: Article)  {
        print(article.articleId)
        bookmarkIds.append(article.articleId)
        self.bookmarkCount = bookmarkIds.count
        // TODO: - Add logic to set bookmark
//        if let index = bookmarks.firstIndex(where: { $0.id == article.id }) {
//            bookmarks.remove(at: index)
//        } else {
//            bookmarks.append(article)
//        }
    }
}
