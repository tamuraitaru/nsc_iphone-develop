//
//  EditNotificationTitleViewModel.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/21.
//

import Foundation
import Combine

class EditNotificationTitleViewModel: ObservableObject {
    @Published var categories: [CategorySelection] = []
    @Published var isAllSelected: Bool = false

    private var apiService: APIForFV
    private var originalSelections: Set<Int> = [] // Ensure this is declared here

    init(apiService: APIForFV) {
        self.apiService = apiService
        loadCategories()
    }

    private func loadCategories() {
        let categoryService = CategoryService(apiService: apiService)
        categoryService.getAllCategories { [weak self] result in
            switch result {
            case .success(let allCategories):
                // Once all categories are fetched, fetch the selected categories
                self?.loadSelectedCategories(allCategories: allCategories)
            case .failure(let error):
                print("Failed to load all categories: \(error.localizedDescription)")
            }
        }
    }

    private func loadSelectedCategories(allCategories: [Notification.Category]) {
        let categoryService = CategoryService(apiService: apiService)
        categoryService.getSelectedCategories { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let selectedCategories):
                    self?.categories = allCategories.map { category in
                        CategorySelection(category: category, isSelected: selectedCategories.contains(category))
                    }
                    // Set original selections to track unsaved changes
                    self?.originalSelections = Set(self?.categories.filter { $0.isSelected }.map { $0.id } ?? [])
                case .failure(let error):
                    print("Failed to load selected categories: \(error.localizedDescription)")
                    self?.categories = allCategories.map { CategorySelection(category: $0, isSelected: false) }
                }
            }
        }
    }
    
    var hasUnsavedChanges: Bool {
        let currentSelections = Set(categories.filter { $0.isSelected }.map { $0.id })
        return currentSelections != originalSelections
    }

    func toggleAllSelection() {
        isAllSelected.toggle()
        categories = categories.map { CategorySelection(category: $0.category, isSelected: isAllSelected) }
    }

    func toggleSelection(for categoryId: Int) {
        if let index = categories.firstIndex(where: { $0.category.id == categoryId }) {
            categories[index].isSelected.toggle()

            if categories[index].isSelected {
                isAllSelected = categories.allSatisfy { $0.isSelected }
            } else {
                isAllSelected = false
            }
        }
    }

    func saveChanges() {
        let selectedIds = categories.filter { $0.isSelected }.map { $0.category.id }
        let categoryService = CategoryService(apiService: apiService)
        categoryService.registerChanges(categoryIds: selectedIds) { success, categories, error in
            if success {
                print("Changes successfully saved")
            } else {
                print("Failed to save changes: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}

struct CategorySelection: Identifiable {
    let category: Notification.Category
    var isSelected: Bool

    var id: Int {
        category.id
    }
}
