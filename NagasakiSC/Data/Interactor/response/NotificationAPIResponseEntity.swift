//
//  NotificationAPIResponseEntity.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/03.
//

import Foundation

struct NotificationAPIResponseEntity: Codable {
    var total: Int?
    var notifications: [Notifications]

    enum CodingKeys: String, CodingKey {
        case total
        case notifications
    }
}

struct Notifications: Codable, Identifiable {
    var id: Int
    var title: String
    var important: Bool
    var isRead: Bool
    var imageUrl: String
    var categories: [Categories]
    var createdAt: String
    var updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case important
        case isRead = "is_read"
        case imageUrl = "image_url"
        case categories
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// struct NotificationAPIResponseEntity: Codable {
//    var total: Int?
//    var notifications: [Notifications]?
// }
//
// struct Notifications: Codable {
//    var id: Int?
//    var title: String?
//    var important: Bool?
//    var isRead: Bool?
//    var imageUrl: String?
//    var categories: [Categories]?
//    var createdAt: Date?
//    var updatedAt: Date?
// }
