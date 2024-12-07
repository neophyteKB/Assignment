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
    @DatabaseAssistant private var databaseManager: DatabaseManager

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
    
    func fetchBookmaks() {
        guard let bookmarks = try? self.databaseManager.fetchBookmarks() else { return }
        self.bookmarkIds = bookmarks.map { $0.id }
        self.bookmarkCount = bookmarkIds.count
    }
    
    func isBookmarked(for articleId: String) -> Bool {
        index(of: articleId) != nil
    }

    func toggleBookmark(article: Article)  {
        if let index = index(of: article.articleId) {
            self.bookmarkIds.remove(at: index)
            try? self.databaseManager.removeBookmark(bookmarkId: article.articleId)
        } else {
            self.bookmarkIds.append(article.articleId)
            try? self.databaseManager.saveBookmark(bookmark: Bookmark(article: article))
        }
        bookmarkCount = bookmarkIds.count
    }
    
    private func index(of id: String) -> Int? {
        bookmarkIds.firstIndex(where: { articleId in articleId == id })
    }
}
