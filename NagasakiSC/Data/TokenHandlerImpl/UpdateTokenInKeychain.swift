//
//  updateTokenInKeychain.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/09.
//

import Foundation
import Security

func updateTokenInKeychain(_ token: String, forKey key: String) {
    let data = token.data(using: .utf8)
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: key
    ]
    let attributes: [String: Any] = [
        kSecValueData as String: data ?? Data()
    ]

    SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
}
