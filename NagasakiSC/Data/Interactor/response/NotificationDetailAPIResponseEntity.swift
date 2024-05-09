//
//  NotificationDetailAPIResponseEntity.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/03.
//

import Foundation

struct NotificationDetailAPIResponseEntity: Codable {
    var id: Int?
    var title: String?
    var topics: String?
    var important: Bool?
    var imageUrl: String?
    var categories: [Categories]?
    var createdAt: Date?
    var updateAt: Date?
}
