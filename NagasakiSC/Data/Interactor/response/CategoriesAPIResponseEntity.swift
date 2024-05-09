//
//  CategoriesAPIResponseEntity.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/03.
//

import Foundation

struct MockCategoriesAPIResponseEntity: Codable {
    var categories: [MockCategories]

    enum CodingKeys: String, CodingKey {
        case categories
    }
}

struct MockCategories: Codable, Identifiable {
    let id: Int
    let order: Int
    let name: String
    let fcmTopic: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case order
        case name
        case fcmTopic = "fcm_topic"
        case createdAt = "created_at"
    }
}

struct MockNotificationCategoriesAPIResponseEntity: Codable {
    var categories: [NotificationCategories]

    enum CodingKeys: String, CodingKey {
        case categories
    }
}

struct NotificationCategories: Codable, Identifiable {
    let id: Int
    let order: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case order
        case name
    }
}

struct CategoriesAPIResponseEntity: Codable {
    var categories: [Categories]

    enum CodingKeys: String, CodingKey {
        case categories
    }
}

struct Categories: Codable, Identifiable {
    let id: Int
    let order: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case order
        case name
    }
}
