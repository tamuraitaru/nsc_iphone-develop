//
//  APIForFV.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/05/06.
//

import Foundation
import OSLog

class APIForFV {
    
    enum UnknownError: Error {
        case generalError(message: String)  // Associate a message with the error
    }
    
    struct ErrorResponse: Decodable {
        let statusCode: Int
        let body: String
    }
    
    func requestAPI(url: URL, httpMethod: String, requestData: Data?, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.httpBody = requestData
        // Authorization ヘッダーを設定
        guard let authorizationHeader = encryptJSON(userId: retrieveToken(forKey: "userId") ?? "", stadiumId: retrieveToken(forKey: "stadiumId") ?? "") else {
            os_log("Failed to generate authorization header for GET to %{PUBLIC}@", log: Logger.network, type: .error)
            return
        }
        var userId = retrieveToken(forKey: "userId")
        var stadiumId = retrieveToken(forKey: "stadiumId")
#if DEBUG
        print("userId: \(String(describing: userId))")
        print("stadiumId: \(String(describing: stadiumId))")
#endif
        
        request.setValue("\(authorizationHeader)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(data, response, error)
        }
        task.resume()
    }
    
    func getRequest<T: Decodable>(path: String, parameters: [String: Any]? = nil, requiresAuthorization: Bool = true, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: URLConfiguration.baseURLFV + path) else {
            os_log("Invalid URL for %{PUBLIC}@", log: Logger.network, type: .error, path)
            completion(.failure(UnknownError.generalError(message: "Invalid URL")))
            return
        }
        os_log("Starting GET request to %{PUBLIC}@", log: Logger.network, type: .info, url.absoluteString)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if requiresAuthorization {
            // Add authorization header if required
            guard let authorizationHeader = encryptJSON(userId: retrieveToken(forKey: "userId") ?? "", stadiumId: retrieveToken(forKey: "stadiumId") ?? "") else {
                os_log("Failed to generate authorization header for GET to %{PUBLIC}@", log: Logger.network, type: .error, path)
                completion(.failure(UnknownError.generalError(message: "No data received")))
                return
            }
            request.setValue("\(authorizationHeader)", forHTTPHeaderField: "Authorization")
        }
        os_log("API Request: %@", log: Logger.network, type: .info, request.debugDescription)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                os_log("GET request error on %{PUBLIC}@: %{PUBLIC}@", log: Logger.network, type: .error, path, error.localizedDescription)
                os_log("API Request Error: %@", log: Logger.network, type: .error, error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                os_log("No data received for %{PUBLIC}@", log: Logger.network, type: .error, path)
                completion(.failure(UnknownError.generalError(message: "No data received")))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                os_log("GET request to %{PUBLIC}@ succeeded", log: Logger.network, type: .info, path)
                completion(.success(decodedData))
            } catch {
                os_log("Decoding error for GET request on %{PUBLIC}@: %{PUBLIC}@", log: Logger.network, type: .error, path, error.localizedDescription)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func notificationsAPI(completion: @escaping (NotificationData?, Error?) -> Void) {
        guard let url = URL(string: URLConfiguration.notificationsFV) else {
            print("Invalid URL")
            completion(nil, UnknownError.generalError(message: "Invalid URL"))
            return
        }
        os_log("Starting GET request to %{PUBLIC}@", log: Logger.network, type: .info, url.absoluteString)
        requestAPI(url: url, httpMethod: "GET", requestData: nil) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                os_log("No data received for %{PUBLIC}@", log: Logger.network, type: .error)
                completion(nil, UnknownError.generalError(message: "API request failed"))
                return
            }
            
            if httpResponse.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let notificationData = try decoder.decode(NotificationData.self, from: data)
                    completion(notificationData, nil) // Success case
                } catch {
                    completion(nil, error)
                }
            } else {
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    completion(nil, UnknownError.generalError(message: errorResponse.body))
                } catch {
                    completion(nil, UnknownError.generalError(message: "API request failed with status code: \(httpResponse.statusCode)"))
                }
            }
        }
    }
    
    func getNotificationByCategory(categoryID: Int?, nip: Int, nop: Int, completion: @escaping (Result<NotificationData, Error>) -> Void) {
        // Construct the API path with parameters as query strings
        var path = "/notification?"
        if let categoryID = categoryID {
            path += "category=\(categoryID)&"
        }
        path += "nip=\(nip)&nop=\(nop)"
        
        // Use the existing `getRequest` method
        getRequest(path: path, requiresAuthorization: true) { (result: Result<NotificationData, Error>) in
            switch result {
            case .success(let notificationData):
                if let categoryID = categoryID {
                    os_log("Successfully fetched notifications for category %{PUBLIC}@", log: Logger.network, type: .info, String(categoryID))
                } else {
                    os_log("Successfully fetched all notifications", log: Logger.network, type: .info)
                }
                completion(.success(notificationData))
            case .failure(let error):
                if let categoryID = categoryID {
                    os_log("Failed to fetch notifications for category %{PUBLIC}@: %{PUBLIC}@", log: Logger.network, type: .error, String(categoryID), error.localizedDescription)
                } else {
                    os_log("Failed to fetch all notifications: %{PUBLIC}@", log: Logger.network, type: .error, error.localizedDescription)
                }
                completion(.failure(error))
            }
        }
    }
    
    func postRequest<T: Encodable>(path: String, requestBody: T, requiresAuthorization: Bool = true, completion: @escaping (Bool, Data?, Error?) -> Void) {
        guard let url = URL(string: URLConfiguration.baseURLFV + path) else {
            os_log("Invalid URL for POST to %{PUBLIC}@", log: Logger.network, type: .error, path)
            completion(false, nil, UnknownError.generalError(message: "Invalid URL"))
            return
        }
        
        do {
            let encoder = JSONEncoder()
            let requestData = try encoder.encode(requestBody)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = requestData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if requiresAuthorization {
                guard let authorizationHeader = encryptJSON(userId: retrieveToken(forKey: "userId") ?? "", stadiumId: retrieveToken(forKey: "stadiumId") ?? "") else {
                    os_log("Failed to generate authorization header for POST to %{PUBLIC}@", log: Logger.network, type: .error, path)
                    completion(false, nil, UnknownError.generalError(message: "Failed to generate authorization header"))
                    return
                }
                request.setValue("\(authorizationHeader)", forHTTPHeaderField: "Authorization")
            }
            
            os_log("Starting POST request to %{PUBLIC}@", log: Logger.network, type: .info, url.absoluteString)
            
            // Log the request body
            if let requestBody = request.httpBody,
               let requestBodyString = String(data: requestBody, encoding: .utf8) {
                os_log("Request Body: %{PUBLIC}@", log: Logger.network, type: .info, requestBodyString)
            }
            
            os_log("API Request: %@", log: Logger.network, type: .info, request.debugDescription)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    os_log("POST request error on %{PUBLIC}@: %{PUBLIC}@", log: Logger.network, type: .error, path, error.localizedDescription)
                    os_log("API Request Error: %@", log: Logger.network, type: .error, error.localizedDescription)
                    completion(false, nil, error)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    os_log("Invalid response for POST to %{PUBLIC}@", log: Logger.network, type: .error, path)
                    completion(false, nil, UnknownError.generalError(message: "Invalid response"))
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    os_log("POST request to %{PUBLIC}@ succeeded with status code: %{PUBLIC}d", log: Logger.network, type: .info, path, httpResponse.statusCode)
                    completion(true, data, nil)
                } else {
                    os_log("POST request to %{PUBLIC}@ failed with status code: %{PUBLIC}d", log: Logger.network, type: .error, path, httpResponse.statusCode)
                    completion(false, nil, UnknownError.generalError(message: "API request failed with status code: \(httpResponse.statusCode)"))
                }
            }
            
            task.resume()
        } catch {
            os_log("Encoding error for POST to %{PUBLIC}@: %{PUBLIC}@", log: Logger.network, type: .error, path, error.localizedDescription)
            completion(false, nil, error)
        }
    }
}
