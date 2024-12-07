//
//  DatabaseManager.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//
import Foundation
import SwiftData

@propertyWrapper
struct DatabaseAssistant {
    private var manager: DatabaseManager?

    var wrappedValue: DatabaseManager {
        get {
            if let manager {
                return manager
            }
            guard let context = try? ModelContext.init(.init(for: Bookmark.self)) else {
                fatalError("Failed to initialize ModelContext")
            }
            return DatabaseManager(context: context)
        }
        set {
            manager = newValue
        }
    }
}

final class DatabaseManager {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func saveBookmark(bookmark: Bookmark) throws {
        do {
            context.insert(bookmark)
            try context.save()
        } catch {
#if DEBUG
            print("Error saving bookmark: \(error)")
#endif
        }
    }

    func removeBookmark(bookmarkId: String) throws {
        let fetchDescriptor = FetchDescriptor<Bookmark>(
            predicate: #Predicate { $0.id == bookmarkId }
        )
        do {
            if let existing = try context.fetch(fetchDescriptor).first {
                context.delete(existing)
                try context.save()
            }
        } catch {
#if DEBUG
            print("Error removing bookmark: \(error)")
#endif
        }
    }

    func fetchBookmarks() throws -> [Bookmark] {
        do {
            let bookmarks = try context.fetch( FetchDescriptor<Bookmark>())
            return bookmarks
        } catch {
#if DEBUG
            print("Error fetching bookmarks: \(error)")
#endif
            return []
        }
    }
}

