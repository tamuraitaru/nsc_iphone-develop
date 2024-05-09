//
//  DeleteToken.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/09.
//

import Foundation
func deleteToken(forKey key: String) {
    deleteTokenFromKeychain(forKey: key)
}
