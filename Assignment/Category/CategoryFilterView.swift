//
//  CategoryFilterView.swift
//  Assignment
//
//  Created by Kamal Kishor on 07/12/24.
//

import SwiftUI

struct CategoryFilterView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: CategoryFilterViewModel
    
    var body: some View {
        NavigationView {
            categoryListView
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        cancelButton
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        applyButton
                    }
                }
        }
    }
    
    private var cancelButton: some View {
        Button("Cancel") {
            self.dismiss()
        }
    }
    
    private var applyButton: some View {
        Button("Apply") {
            self.viewModel.onApplyTapped()
            self.dismiss()
        }
        .disabled(!self.viewModel.isApplyEnabled)
    }
    
    private var categoryListView: some View {
        List(NewsCategory.allCases, id: \.self) { category in
            CategoryCard(
                category: category,
                isSelected: self.viewModel.isSelected(category: category)
            )
            .onTapGesture {
                self.viewModel.onRowTapped(category: category)
            }
        }
    }
}

private struct CategoryCard: View {
    var category: NewsCategory
    var isSelected: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            checkboxIcon
            categoryTitle
        }
    }
    
    private var checkboxIcon: some View {
        Image(systemName: (isSelected ? "checkmark.seal.fill" : "checkmark.seal"))
            .padding()
    }
    
    private var categoryTitle: some View {
        Text(category.rawValue)
            .font(.title3)
            .fontWeight(.semibold)
    }
}

#Preview {
    CategoryFilterView(
        viewModel: .init(
            selectedCategories: [.business, .sports, .technology], completion: {_ in }
        )
    )
}
