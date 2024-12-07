//
//  BookmarksViewModel.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//
import Foundation

@MainActor
final class BookmarksViewModel: ObservableObject {
    @Published var bookmarks: [Bookmark] = []
    @Published var hasError: Bool = false
    @DatabaseAssistant private var databaseManager: DatabaseManager
    
    var errorString: String?
    
    init() {
        fetchBookmarks()
    }
    
    func fetchBookmarks() {
        do {
            self.bookmarks = try databaseManager.fetchBookmarks()
        } catch {
            errorString = error.localizedDescription
            hasError = true
        }
    }
    
    func deleteBookmarkTapped(for id: String) {
        do {
            try self.databaseManager.removeBookmark(bookmarkId: id)
            self.bookmarks = try databaseManager.fetchBookmarks()
        } catch {
            errorString = error.localizedDescription
            hasError = true
        }
    }
}
