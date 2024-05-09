//
//  CategoryService.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/29.
//

import Foundation
import OSLog

class CategoryService {
    private let apiService: APIForFV

    init(apiService: APIForFV) {
        self.apiService = apiService
    }

    func getAllCategories(completion: @escaping (Result<[Notification.Category], Error>) -> Void) {
        apiService.getRequest(path: "/categories", requiresAuthorization: false) { (result: Result<CategoriesResponse, Error>) in
            switch result {
            case .success(let categoriesResponse):
                os_log("Successfully retrieved categories", log: Logger.network, type: .info)
                completion(.success(categoriesResponse.categories))
            case .failure(let error):
                os_log("Error retrieving categories: %{PUBLIC}@", log: Logger.network, type: .error, error.localizedDescription)
                completion(.failure(error))
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

    func registerChanges(categoryIds: [Int], completion: @escaping (Bool, [Notification.Category]?, Error?) -> Void) {
        let path = "/categories"
        struct RequestBody: Encodable {

            let categoryIds: [Int]
            enum CodingKeys: String, CodingKey {
                case categoryIds = "category_ids"
            }
        }

        os_log("POST request body for selected categories: %@", log: Logger.network, type: .info, String(describing: categoryIds))
        let requestBody = RequestBody(categoryIds: categoryIds)

        apiService.postRequest(path: path, requestBody: requestBody) { success, responseData, error in
            if success {
                os_log("Successfully post selected categories", log: Logger.network, type: .info)
                if let data = responseData {
                    do {
                        let decoder = JSONDecoder()
                                            let categoriesResponse = try decoder.decode(CategoriesResponse.self, from: data)
                                            let categories = categoriesResponse.categories
                                            completion(true, categories, nil)
                    } catch {
                        os_log("Failed to decode response data for %{PUBLIC}@: %{PUBLIC}@", log: Logger.network, type: .error, path, error.localizedDescription)
                        completion(false, nil, error)
                    }
                } else {
                    os_log("No response data received for %{PUBLIC}@", log: Logger.network, type: .error, path)
                    completion(false, nil, APIForFV.UnknownError.generalError(message: "No response data received"))
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}

struct CategoriesResponse: Decodable {
    let categories: [Notification.Category]
}

struct SelectedCategoriesIdentifiers: Decodable {
    let selectedCategoryIds: [Int]
}
