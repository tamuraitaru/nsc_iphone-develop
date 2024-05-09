//
//  NotificationTabViewModel.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/05/02.
//

import Foundation
import OSLog

class NotificationTabViewModel: ObservableObject {
    @Published var categories: [NotificationTabItem] = []
    @Published var selectedCategory: NotificationTabItem?
    @Published var allNotifications: [Notification] = []
    
    @Published var isLoading = false
    @Published var error: Error?

    private let apiService = APIForFV()

    func fetchCategories(completion: @escaping () -> Void) {
        getSelectedCategories { [weak self] result in
            switch result {
            case .success(let fetchedCategories):
                DispatchQueue.main.async {
                    self?.categories = fetchedCategories.map { NotificationTabItem(id: $0.id, name: $0.name) }
                    self?.selectedCategory = self?.categories.first
                    completion()
                }
            case .failure(let error):
                // Handle the error
                print("Error fetching categories: \(error)")
                completion()
            }
        }
    }

    func fetchNotifications(forCategoryID categoryID: Int? = nil, nip: Int = 10, nop: Int = 0) {
        isLoading = true
        
        let categoryString = categoryID?.description ?? "all"
        os_log("Fetching notifications for category ID: %{PUBLIC}@", log: Logger.network, type: .info, categoryString)
        
        apiService.getNotificationByCategory(categoryID: categoryID, nip: nip, nop: nop) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let notificationData):
                    os_log("Notifications fetched successfully for category ID: %{PUBLIC}@", log: Logger.network, type: .info, categoryString)
                    
                    if let categoryID = categoryID {
                        // Update the notifications for the specific category
                        if let index = self?.categories.firstIndex(where: { $0.id == categoryID }) {
                            self?.categories[index].notifications = notificationData.notifications
                        }
                    } else {
                        // Update allNotifications when no category is specified
                        self?.allNotifications = notificationData.notifications

                    }
                    
                case .failure(let error):
                    os_log("Error fetching notifications: %{PUBLIC}@", log: Logger.network, type: .error, String(describing: error))
                    self?.error = error
                }
            }
        }
    }

    func getSelectedCategories(completion: @escaping (Result<[Notification.Category], Error>) -> Void) {
        apiService.getRequest(path: "/categories/setting", requiresAuthorization: true) { (result: Result<CategoriesResponse, Error>) in
            switch result {
            case .success(let categoriesResponse):
                os_log("Successfully retrieved selected categories", log: Logger.network, type: .info)
                completion(.success(categoriesResponse.categories))
            case .failure(let error):
                os_log("Error retrieving selected categories: %{PUBLIC}@", log: Logger.network, type: .error, error.localizedDescription)
                completion(.failure(error))
            }
        }
    }

    func updateSelectedCategory(_ category: NotificationTabItem) {
        selectedCategory = category
        fetchNotifications(forCategoryID: category.id)
    }
}
