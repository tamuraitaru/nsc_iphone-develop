//
//  RetrieveToken.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/09.
//

import Foundation
func retrieveToken(forKey key: String) -> String? {
    return retrieveTokenFromKeychain(forKey: key)
}
