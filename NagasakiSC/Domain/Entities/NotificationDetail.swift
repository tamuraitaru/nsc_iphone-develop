//
//  NotificationDetail.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/05/04.
//

import Foundation

struct NotificationDetail: Identifiable, Decodable {
    let id: Int
    let title: String
    let topics: String
    let important: Bool
    let imageUrl: String?
    let termFrom: String
    let categories: [Category]

    enum CodingKeys: String, CodingKey {
        case id, title, topics, important, categories
        case termFrom = "term_from"
        case imageUrl = "image_url"
    }

    struct Category: Decodable {
        let id: Int
        let name: String
        let order: Int
    }
}
