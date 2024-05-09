//
//  String+Extension.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/04.
//

import Foundation

extension String {
    // String型からData型への変換
    func toData() -> Data? {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            return data
        } catch {
            print("Error while converting Notifications to data: \(error)")
            return nil
        }
    }
}
