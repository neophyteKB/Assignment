//
//  BookmarksListView.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//
import SwiftUI

struct BookmarksListView: View {
    @StateObject var viewModel: BookmarksViewModel = .init()

    var body: some View {
        bookmarksView
            .navigationTitle("Bookmarks")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
    }
    
    private var bookmarksView: some View {
        List($viewModel.bookmarks, id: \.id) { bookmark in
            FeedCardView(
                icon: bookmark.sourceIcon.wrappedValue,
                title: bookmark.title.wrappedValue,
                description: bookmark.desc.wrappedValue,
                sourceUrl: bookmark.sourceUrl.wrappedValue
            )
            .swipeActions(edge: .trailing) {
                Button(
                    action: { self.viewModel.deleteBookmarkTapped(for: bookmark.id) },
                    label: { self.bookmarkDeleteIcon }
                )
            }
            .listStyle(.plain)
        }
    }
    
    private var bookmarkDeleteIcon: some View {
        Image(systemName: "trash")
            .tint(.red)
    }
}
#Preview {
    BookmarksListView()
}
