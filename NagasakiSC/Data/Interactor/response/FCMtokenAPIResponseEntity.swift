//
//  FCMtokenAPIResponseEntity.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/03.
//

import Foundation

struct FCMtokenAPIResponseEntity: Codable {
    var fcmToken: String?

    enum CodingKeys: String, CodingKey {
        case fcmToken = "fcm_token"
    }
}
