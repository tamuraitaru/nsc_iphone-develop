//
//  RequestProtocol.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/03/21.
//

import Foundation

protocol RequestProtocol {
    associatedtype Response: Codable
    var baseUrl: String {get}
    var path: String {get}
    var method: String {get}
    var headers: [String: String]? {get}
    var body: Data? { get }
}

extension RequestProtocol {
    var baseUrl: String {
        return APIClient.Environment.domain
    }

    var headers: [String: String]? {
        return nil
    }

    var body: Data? {
        return nil
    }

    func urlRequest() -> URLRequest {
        let url = URL(string: baseUrl + path)!
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }
}
