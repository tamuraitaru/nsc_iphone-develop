//
//  MainTabViewModel.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/05/02.
//

import Foundation
import Combine

class MainTabViewModel: ObservableObject {
    @Published var notificationCategories: [NotificationTabItem] = []
    private var cancellableSet: Set<AnyCancellable> = []

    private let categoryService: CategoryService

    init(categoryService: CategoryService) {
        self.categoryService = categoryService
        loadCategories()
    }

    private func loadCategories() {
        categoryService.getAllCategories { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    self?.notificationCategories = categories.map {
                        NotificationTabItem(id: $0.id, name: $0.name, notifications: nil)
                    }
                case .failure(let error):
                    print("Failed to load categories: \(error)")
                }
            }
        }
    }
}
