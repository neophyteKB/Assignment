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
        ZStack(alignment: .topTrailing) {
            bookmarkIcon
            badgeView
        }
        .frame(width: 44.0, height: 44.0)
    }
    
    private var bookmarkIcon: some View {
        Image(systemName: "bookmark.fill")
            .foregroundColor(.red)
            .padding()
    }
    
    private var badgeView: some View {
        Text("\(bookmarkCount)")
            .font(.caption2)
            .foregroundColor(.white)
            .frame(width: 20.0, height: 20.0)
            .background(Circle().fill(Color.blue))
            .padding([.top, .trailing], 8.0)
    }
}

#Preview {
    BookmarkButton(bookmarkCount: .constant(4))
}
