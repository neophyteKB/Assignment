//
//  AssignmentTests.swift
//  AssignmentTests
//
//  Created by Kamal Kishor on 02/12/24.
//

import Testing
@testable import Assignment
import Combine

final class AssignmentTests {
    
    private var hasError: Bool = false

    @Test func feedsFetchedSuccess() async {
        // Given
        let feeds = JsonParser.feeds
        let mockNetworkManager = MockNetworkManager(articles: feeds)
        
        // When
        let viewModel = await NewsFeedViewModel(apiManager: mockNetworkManager)
        await viewModel.fetchArticles()
        let _ = await viewModel.$hasError
            .sink { hasError in self.hasError = hasError }
        
        // Then
        await #expect(!viewModel.articles.isEmpty)
        await #expect(viewModel.articles.count == 10)
        #expect(!hasError)
    }

    @Test func feedsFetchFailed() async {
        // Given
        let error = NetworkError.serverError(code: "Test", message: "You got it")
        let mockNetworkManager = MockNetworkManager(error: error)
        
        // When
        let viewModel = await NewsFeedViewModel(apiManager: mockNetworkManager)
        await viewModel.fetchArticles()
        let _ = await viewModel.$hasError
            .sink { hasError in self.hasError = hasError }
        
        // Then
        let errorMsg = await viewModel.error
        await #expect(viewModel.articles.isEmpty)
        #expect(errorMsg.contains("Test"))
        #expect(errorMsg.contains("You got it"))
        #expect(hasError)
    }
    
    @Test func toggleBookmark() async {
        // Given
        let feeds = JsonParser.feeds
        let mockNetworkManager = MockNetworkManager(articles: feeds)
        let viewModel = await NewsFeedViewModel(apiManager: mockNetworkManager)
        let articleToBookmark = feeds.first!
        
        // When
        await viewModel.fetchArticles()
        await viewModel.toggleBookmark(article: articleToBookmark)
        
        await #expect(viewModel.bookmarkCount == 1)
    }
}
