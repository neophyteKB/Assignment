//
//  NewsFeedViewModel.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//

import Combine

@MainActor
final class NewsFeedViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var bookmarks: [Bookmark] = []
    @Published var showLoader: Bool = false
    @Published var selectedCategory: NewsCategory = .none
    @Published var hasError: Bool = false
    var error: Error? = nil

    private let apiManager: NetworkManager

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

    func toggleBookmark(article: Article) {
        // TODO: - Add logic to set bookmark
//        if let index = bookmarks.firstIndex(where: { $0.id == article.id }) {
//            bookmarks.remove(at: index)
//        } else {
//            bookmarks.append(article)
//        }
    }
}
