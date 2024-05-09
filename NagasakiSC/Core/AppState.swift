//
//  AppState.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/11.
//

import Foundation
import Combine

class AppState: ObservableObject {
    static let shared = AppState()

    @Published var isAuthLogin: Bool

    init() {
        self.isAuthLogin = UserDefaults.standard.bool(forKey: "auth_login")
    }
}
