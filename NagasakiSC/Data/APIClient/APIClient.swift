//
//  APIClient.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/03/21.
//

import Foundation
import Combine

protocol APIClientProtocol {
    func successHandler(apiType: APIClient.APIType, response: Any?)
    func errorHander(apiType: APIClient.APIType, response: Any?)
}

extension APIClientProtocol {
    func successHandler(apiType: APIClient.APIType, response: Any?) {}
    func errorHandler(apiType: APIClient.APIType, response: Any?) {}
}

//class ErrorResponse {
//    enum Status {
//        case none
//        case expired
//        case notFound
//        case optimisiticRock
//
//        func code() -> String {
//            switch self {
//            case .none:
//                return "200"
//            case .expired:
//                return "401"
//            case .notFound:
//                return "404"
//            case .optimisiticRock:
//                return "412"
//            }
//        }
//
//        static func fromCode(_ code: Int?) -> Status? {
//            guard let code = code else {
//                return nil
//            }
//            switch code {
//            case 200:
//                return ErrorResponse.Status.none
//            case 401:
//                return .expired
//            case 404:
//                return .notFound
//            case 412:
//                return .optimisiticRock
//            default:
//                return nil
//            }
//        }
//    }
//}

class APIClient {
    private var cancellables = Set<AnyCancellable>()

    struct Environment {
        static var domain: String {
            //   FV開発環境
            return "https://d38erep2zx5w1s.cloudfront.net/dev/api/v1"
            // 開発環境
//            return "https://test-app.nagasakistadiumcity.com"
            //   本番環境
//            return "https://app.nagasakistadiumcity.com/"
        }
    }

    private func callAPIPublisher<T: RequestProtocol>(_ apiType: APIType, request: T) -> AnyPublisher<Data, Error> {
        let baseURL = request.baseUrl
        let path = request.path
        let requestURL = URL(string: baseURL + path)!
        let method = request.method
        let headers = request.headers

        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = method
        headers?.forEach { key, value  in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        if let bodyData = request.body {
            urlRequest.httpBody = bodyData
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                guard 200 ..< 300 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .mapError { error in
                error as Error
            }
            .eraseToAnyPublisher()
    }

    enum APIType {
        case userRegister
        case userChangeInfo
        case userGetInfo
        case categories
        case categoriesSetting
        case categoriesEdit
        case fcmToken
        case notification
        case notificationDetail
        case notificationOpend
        case mock

        var apiPath: String {
            return "/\(path)"
        }

        var path: String {
            switch self {
            case .userRegister:
                return "user"
            case .userChangeInfo:
                return "user"
            case .userGetInfo:
                return "user"
            case .categories:
                return "categories"
            case .categoriesSetting:
                return "categories/setting"
            case .categoriesEdit:
                return "categories"
            case .fcmToken:
                return "fcmtoken"
            case .notification:
                return "notification"
            case .notificationDetail:
                return "notification/:notification_id"
            case .notificationOpend:
                return "notification/:notification_id"
            case .mock:
                return "categories"
            }
        }
    }

    private func apiClientCallHandler<T: RequestProtocol>(_ apiType: APIClient.APIType, request: T, delegate: APIClientProtocol?) {
        APIClient().callAPIPublisher(apiType, request: request)
            .sink { completion in
                switch completion {
                case .finished:
                    print("API request completed successfully.")
                case .failure(let error):
                    if let urlError = error as? URLError,
                       let httpResponse = urlError.userInfo[NSURLErrorKey] as? HTTPURLResponse {
                        let statusCode = httpResponse.statusCode
                        print("API request failed with status code: \(statusCode)")
                    } else {
                        print("API request failed with error: \(error)")
                    }
                    delegate?.errorHandler(apiType: apiType, response: error)
                }
            } receiveValue: { response in
                delegate?.successHandler(apiType: apiType, response: response)
            }
            .store(in: &cancellables)
    }
    func callAPI(_ apiType: APIType, params: [String: Any], delegate: APIClientProtocol?) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: params)
            if let createRequest = requestCreationMap[apiType] {
                let request = createRequest(jsonData)
                apiClientCallHandler(apiType, request: request, delegate: delegate)
            } else {
                print("Unknown API type: \(apiType)")
            }
        } catch {
            print("Error converting JSON data to Data: \(error)")
        }
    }

    private let requestCreationMap: [APIType: (Data) -> any RequestProtocol] = [
        .userRegister: { jsonData in NagasakiSCAPI.UserRegister(body: jsonData) },
        .userChangeInfo: { jsonData in NagasakiSCAPI.UserChangeInfo(body: jsonData) },
        .userGetInfo: { jsonData in NagasakiSCAPI.UserGetInfo(body: jsonData) },
        .categories: { jsonData in NagasakiSCAPI.Categories(body: jsonData) },
        .categoriesSetting: { jsonData in NagasakiSCAPI.CategoriesSetting(body: jsonData) },
        .categoriesEdit: { jsonData in NagasakiSCAPI.CategoriesEdit(body: jsonData) },
        .fcmToken: { jsonData in NagasakiSCAPI.FCMToken(body: jsonData) },
        .notification: { jsonData in NagasakiSCAPI.Notification(body: jsonData) },
        .notificationDetail: { jsonData in NagasakiSCAPI.NotificationDetail(body: jsonData) },
        .notificationOpend: { jsonData in NagasakiSCAPI.NotificationOpend(body: jsonData) },
        .mock: { jsonData in NagasakiSCAPI.Mock(body: jsonData) }
    ]
}
