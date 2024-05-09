//
//  deleteTokenFromKeychain.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/09.
//

import Foundation
import Security

func deleteTokenFromKeychain(forKey key: String) {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: key
    ]

    SecItemDelete(query as CFDictionary)
}
