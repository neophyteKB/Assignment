//
//  NewsFeedViewModel.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//

import Combine

@MainActor
class NewsFeedViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var filteredArticles: [Article] = []
    @Published var bookmarks: [Article] = []
    @Published var selectedCategory: String = "All"

    private let apiManager: NetworkManager

    init(apiManager: NetworkManager = NetworkManager()) {
        self.apiManager = apiManager
        fetchArticles()
    }

    func fetchArticles() {
        Task {
            self.articles = await apiManager.fetchArticles()
            self.filterArticles()
        }
    }

    func filterArticles() {
        filteredArticles = selectedCategory == "All"
            ? articles
            : articles.filter { $0.category == selectedCategory }
    }

    func toggleBookmark(article: Article) {
        if let index = bookmarks.firstIndex(where: { $0.id == article.id }) {
            bookmarks.remove(at: index)
        } else {
            bookmarks.append(article)
        }
    }
}
