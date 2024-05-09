//
//  SaveToken.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/09.
//

import Foundation
func saveToken(_ token: String, forKey key: String) {
    if retrieveToken(forKey: key) != nil {
        updateToken(token, forKey: key)
    }
    saveTokenToKeychain(token, forKey: key)
}
