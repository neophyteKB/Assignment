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
            NavigationLink(
                destination: {
                    destination(bookmark: bookmark.wrappedValue)
                },
                label: {
                    self.cardView(bookmark: bookmark.wrappedValue)
                }
            )
        }
    }
    
    private func cardView(bookmark: Bookmark) -> some View {
        FeedCardView(
            icon: bookmark.sourceIcon,
            title: bookmark.title,
            description: bookmark.desc,
            sourceUrl: bookmark.sourceUrl
        )
        .swipeActions(edge: .trailing) {
            Button(
                action: { self.viewModel.deleteBookmarkTapped(for: bookmark.id) },
                label: { self.bookmarkDeleteIcon }
            )
        }
        .listStyle(.plain)
    }
    
    private func destination(bookmark: Bookmark) -> some View {
        DetailsView(
            viewModel: .init(
                title: bookmark.title,
                content: bookmark.content,
                desc: bookmark.desc,
                link: bookmark.link,
                source: .init(
                    name: bookmark.sourceName,
                    icon: bookmark.sourceIcon,
                    url: bookmark.sourceUrl
                ),
                dateString: bookmark.pubDate.dateString(for: bookmark.pubDateTZ)
            )
        )
    }
    
    private var bookmarkDeleteIcon: some View {
        Image(systemName: "trash")
            .tint(.red)
    }
}
#Preview {
    BookmarksListView()
}
