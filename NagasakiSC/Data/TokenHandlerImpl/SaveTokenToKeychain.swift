//
//  saveTokenToKeychain.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/09.
//

import Foundation
import Security

func saveTokenToKeychain(_ token: String, forKey key: String) {
    let data = token.data(using: .utf8)
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: key,
        kSecValueData as String: data ?? Data()
    ]
    SecItemAdd(query as CFDictionary, nil)
}
