//
//  GuestRegisterAPIResponseEntity.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/03/26.
//

import Foundation

// 仮の値として設定しました。
struct UserRegisterAPIResponseEntity: Codable {
    var userId: Int

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
    }
}
