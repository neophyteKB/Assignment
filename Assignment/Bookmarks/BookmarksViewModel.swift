//
//  BookmarksViewModel.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//
import Foundation
import Combine

@MainActor
final class BookmarksViewModel: ObservableObject {
    @Published var bookmarks: [Bookmark] = []
    
    init() {
        fetchBookmarks()
    }
    
    func fetchBookmarks() {
        // Add code to pull bookmarks from DB
    }
}
