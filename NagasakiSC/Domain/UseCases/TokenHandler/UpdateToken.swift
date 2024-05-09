//
//  UpdateToken.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/09.
//

import Foundation
func updateToken(_ token: String, forKey key: String) {
    updateTokenInKeychain(token, forKey: key)
}
