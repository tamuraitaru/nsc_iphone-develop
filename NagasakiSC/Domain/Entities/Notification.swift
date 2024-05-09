//
//  Notification.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/23.
//

import Foundation

struct NotificationData: Decodable {
    let total: Int
    let notifications: [Notification]
}

struct Notification: Identifiable, Decodable {
    let id: Int
    let title: String
    let topics: String
    let important: Bool
    let isRead: Bool
    let categories: [Category]?
    let termFrom: String
    let imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case id, title, topics, important, categories
        case isRead = "is_read"
        case termFrom = "term_from"
        case imageUrl = "image_url"
    }

    struct Category: Decodable {
        let id: Int
        let name: String
        let order: Int
    }
}

extension Notification.Category: Equatable {
    static func == (lhs: Notification.Category, rhs: Notification.Category) -> Bool {
        return lhs.id == rhs.id  // Assuming equality is based on `id`
    }
}
