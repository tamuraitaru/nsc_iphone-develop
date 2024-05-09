//
//  EncryptAutorizationHeader.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/09.
//

import Foundation
import CryptoSwift
import KeychainSwift

let keychain = KeychainSwift()
let apiKeyKeychainKey = "APIKey"
let accessTokenKeychainKey = "AccessToken"
let idTokenKeychainKey = "IDToken"

func encryptJSON(userId: String, stadiumId: String) -> String? {
    // Retrieve the access token and ID token from the Keychain
    guard let accessToken = keychain.get(accessTokenKeychainKey),
          let idToken = keychain.get(idTokenKeychainKey) else {
        print("Access token or ID token not found in Keychain")
        return nil
    }
    // Create the JSON dictionary
    let json: [String: Any] = [
        "user_id": userId,
        "stadium_id": stadiumId
    ]

    // Convert the JSON to Data
    guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) else {
        return nil
    }

    // Use the predefined API key and IV from the EncryptionConstants
    let aesKey = Array(EncryptionConstants.keyword.utf8)
    let initVector = [UInt8](hex: EncryptionConstants.initVector) // Convert hex string to byte array

    // Encrypt the JSON data using AES-256
    do {
        let encryptedData = try AES(key: aesKey, blockMode: CBC(iv: initVector), padding: .pkcs7).encrypt(jsonData.bytes)
        let encryptedBase64 = Data(encryptedData).base64EncodedString()
        return encryptedBase64
    } catch {
        print("Error encrypting JSON: \(error)")
        return nil
    }
}
