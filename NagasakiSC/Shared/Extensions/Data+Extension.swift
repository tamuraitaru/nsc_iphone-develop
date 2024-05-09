//
//  Data+Extension.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/04.
//

import Foundation

extension Data {
    // Data型からSet<String>型への変換
    func toStrings() -> Set<String> {
        do {
            if let strings = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, NSString.self], from: self) as? Set<String> {
                return strings
            } else {
                print("Failed to convert data to Notifications")
                return [""]
            }
        } catch {
            print("Error while converting data to Notifications: \(error)")
            return [""]
        }
    }
}
