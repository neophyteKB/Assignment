//
//  NewsFeedView.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//

import SwiftUI

struct NewsFeedView: View {
    
    @StateObject var viewModel = NewsFeedViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Category", selection: $viewModel.selectedCategory) {
                    Text("All").tag("All")
                    Text("Technology").tag("Technology")
                    Text("Sports").tag("Sports")
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: viewModel.selectedCategory) { _, _ in
                    viewModel.filterArticles()
                }
                
                List(viewModel.filteredArticles) { article in
                    // Navigate to next details screen
//                    NavigationLink(destination: ArticleDetailView(article: article)) {
//                        Text(article.title)
//                    }
                }
            }
            .navigationTitle("News Reader")
            .toolbar {
                NavigationLink("Bookmarks") {
                    // Navigate to bookbark screen
//                    BookmarksView(viewModel: viewModel)
                }
            }
        }
    }
}
