//
//  CategoryButtonView.swift
//  Assignment
//
//  Created by Kamal Kishor on 07/12/24.
//

import SwiftUI

struct CategoryButtonView: View {
    
    @Binding var selectedCategories: [NewsCategory]
    @State var isFilterSheetPresented: Bool = false
    
    var body: some View {
        categoryFilterView
            .sheet(isPresented: $isFilterSheetPresented) {
                CategoryFilterView(
                    viewModel: .init(
                        selectedCategories: selectedCategories,
                        completion: { categories in
                            self.selectedCategories = categories
                        }
                    )
                )
            }
    }
    
    private var categoryFilterView: some View {
        ZStack(alignment: .topTrailing) {
            filterIcon
            badgeView
        }
        .frame(width: 44.0, height: 44.0)
    }
    
    private var filterIcon: some View {
        Image(systemName: "engine.emission.and.filter")
            .foregroundColor(.blue)
            .padding()
            .onTapGesture {
                isFilterSheetPresented.toggle()
            }
    }
    
    @ViewBuilder
    private var badgeView: some View {
        if !selectedCategories.isEmpty {
            Text("\(selectedCategories.count)")
                .font(.caption2)
                .foregroundColor(.white)
                .frame(width: 20.0, height: 20.0)
                .background(Circle().fill(Color.red))
                .padding([.top, .trailing], 8.0)
        }
    }
}

#Preview {
    CategoryButtonView(
        selectedCategories: .constant([
                .business,
                .sports,
                .technology
            ]
        )
    )
}
