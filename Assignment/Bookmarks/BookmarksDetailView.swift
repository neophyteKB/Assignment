//
//  BookmarksDetailView.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//
import SwiftUI

struct ArticleDetailView: View {
    let article: Article

    var body: some View {
        ScrollView {
            Text(article.content)
                .padding()
        }
        .navigationTitle(article.title)
    }
}

#Preview {
    ArticleDetailView(article: .init(id: .init(), title: "Title", summary: "Summary", content: "Content", category: "Category"))
}
