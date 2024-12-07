//
//  CategoryFilterViewModel.swift
//  Assignment
//
//  Created by Kamal Kishor on 07/12/24.
//

import Foundation

@MainActor
final class CategoryFilterViewModel: ObservableObject {
    
    @Published var isApplyEnabled: Bool = false
    var selectedCategories: [NewsCategory] = []
    private let completion: (([NewsCategory]) -> Void)
    private var initialFilterCategories: [NewsCategory]
    
    init(selectedCategories: [NewsCategory], completion: @escaping ([NewsCategory]) -> Void) {
        self.selectedCategories = selectedCategories
        self.initialFilterCategories = selectedCategories
        self.completion = completion
    }
    
    func onApplyTapped() {
        self.completion(selectedCategories)
    }
    
    func isSelected(category: NewsCategory) -> Bool {
        indexOf(category: category) != nil
    }
    
    func onRowTapped(category: NewsCategory) {
        if let index = self.indexOf(category: category) {
            self.selectedCategories.remove(at: index)
        } else {
            self.selectedCategories.append(category)
        }
        self.checkForApplyEnabled()
    }
    
    private func indexOf(category: NewsCategory) -> Int? {
        selectedCategories.firstIndex(of: category)
    }
    
    private func checkForApplyEnabled() {
        func isEqual() -> Bool {
            if selectedCategories.count != initialFilterCategories.count { return false }
            let initialQueryString = initialFilterCategories.map(\.query).sorted().joined()
            let selectedQueryString = selectedCategories.map(\.query).sorted().joined()
            return initialQueryString == selectedQueryString
        }
        isApplyEnabled = !isEqual()
    }
}
