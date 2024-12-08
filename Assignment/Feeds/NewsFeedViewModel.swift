//
//  NewsFeedViewModel.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//

import Combine
import Foundation

@MainActor
final class NewsFeedViewModel: ObservableObject, Sendable {
    @Published var articles: [Article] = []
    @Published var searchText: String = ""
    @Published var showLoader: Bool = false
    @Published var hasError: Bool = false
    @Published var bookmarkCount: Int = 0
    @Published var categoryFilter: [NewsCategory] = []
    @Published var tryAgain: Bool = false
    var error: String = ""

    private let apiManager: NetworkManager
    private var bookmarkIds: [String] = .init()
    private var cancellables: Set<AnyCancellable> = .init()
    @DatabaseAssistant private var databaseManager: DatabaseManager

    init(apiManager: NetworkManager = NetworkManagerImp()) {
        self.showLoader = true
        self.apiManager = apiManager
        self.setupObservers()
    }

    func fetchArticles() async {
        do {
            let articles = try await apiManager.fetchArticles(
                categories: categoryFilter,
                query: searchText
            )
            self.articles = articles
        } catch {
            self.handle(error: error)
        }
        self.showLoader = false
    }
    
    private func setupObservers() {
        $searchText
            .dropFirst()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                Task {
                    await self?.fetchArticles()
                }
            }
            .store(in: &cancellables)
        
        $categoryFilter
            .dropFirst()
            .sink { [weak self] _ in
                Task {
                    await self?.fetchArticles()
                }
            }
            .store(in: &cancellables)
        
        $tryAgain
            .receive(on: DispatchQueue.main)
            .sink { [weak self] tryAgain in
                if tryAgain {
                    self?.showLoader = true
                    Task {
                        await self?.fetchArticles()
                    }
                }
            }
            .store(in: &cancellables)
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
    
    private func handle(error: Error) {
        var errorString: String {
            if let networkError = error as? NetworkError {
                return networkError.message
            } else {
                return error.localizedDescription
            }
        }
        self.error = errorString
        hasError = true
    }
}
