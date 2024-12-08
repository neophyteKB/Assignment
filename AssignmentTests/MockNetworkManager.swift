//
//  MockNetworkManager.swift
//  AssignmentTests
//
//  Created by Kamal Kishor on 08/12/24.
//


import Testing
@testable import Assignment

final class MockNetworkManager: NetworkManager {
    var articles: [Article] = []
    var error: NetworkError?
    
    init(articles: [Article] = [], error: NetworkError? = nil) {
        self.articles = articles
        self.error = error
    }
    
    func fetchArticles(categories: [NewsCategory], query: String?) async throws -> [Article] {
        if let error { throw error }
        return articles
    }
}
