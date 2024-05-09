//
//  retrieveTokenFromKeychain.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/09.
//

import Foundation
import Security

func retrieveTokenFromKeychain(forKey key: String) -> String? {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: key,
        kSecReturnData as String: true
    ]

    var result: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &result)

    if status != errSecSuccess {
        if let errorString = SecCopyErrorMessageString(status, nil) {
            print("Failed to access keychain: \(errorString)")
        } else {
            print("Failed to access keychain with status: \(status)")
        }
    }

    if status == errSecSuccess {
        if let data = result as? Data,
           let token = String(data: data, encoding: .utf8) {
            return token
        }
    }

    return nil
}
