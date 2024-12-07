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
        List(viewModel.bookmarks) { article in
            Text(article.title)
        }
        .navigationTitle("Bookmarks")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
}
#Preview {
    BookmarksListView()
}
