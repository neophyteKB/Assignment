//
//  BookmarkButton.swift
//  Assignment
//
//  Created by Kamal Kishor on 06/12/24.
//

import SwiftUI

struct BookmarkButton: View {

    @Binding var bookmarkCount: Int
    
    var body: some View {
        if bookmarkCount > 0 {
            NavigationLink {
                BookmarksListView()
            } label: {
                bookmarkButton
            }
        }
    }
    
    private var bookmarkButton: some View {
        Image(systemName: "bookmark.fill")
            .foregroundColor(.red)
            .padding()
        .frame(width: 44.0, height: 44.0)
    }
}

#Preview {
    BookmarkButton(bookmarkCount: .constant(4))
}
