//
//  DatabaseManager.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//
import Foundation
import SwiftData

final class DatabaseManager {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func saveBookmark(_ bookmark: Bookmark) throws {
        // TODO: Facing issues, has to check this again.
//        do {
//            try context.insert(bookmark)
//            try context.save()
//        } catch {
//            print("Error saving bookmark: \(error)")
//        }
    }

    func removeBookmark(_ bookmark: Bookmark) throws {
        // TODO: Facing issues, has to check this again.
//        do {
//            if let existing = try context.fetch(Bookmark.self, where: { $0.id == bookmark.id }).first {
//                try context.delete(existing)
//                try context.save()
//            }
//        } catch {
//            print("Error removing bookmark: \(error)")
//        }
    }

    func fetchBookmarks() throws -> [Bookmark] {
        // TODO: Facing issues, has to check this again.
//        do {
//            try context.fetch(Bookmark.self)
//        } catch {
//            print("Error fetching bookmarks: \(error)")
            return []
//        }
    }
}

