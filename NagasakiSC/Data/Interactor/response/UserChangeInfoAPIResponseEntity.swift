//
//  a.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/03.
//

import Foundation

// 仮の値として設定しました。
struct UserChangeInfoAPIResponseEntity: Codable {
    var userId: Int?
    var stadiumId: String?

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case stadiumId = "stadium_id"
    }
}
