//
//  TutorialAuthViewModel.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/15.
//

import Foundation
import SwiftUI

class TutorialAuthViewModel: ObservableObject {
    @Published var isNotificationPermissionViewActive = false
    @Published var isAuthViewActive = false

    func toLoginOrSignUpView() {
        isAuthViewActive = true
    }

    func guestLogin() {
        isNotificationPermissionViewActive = true
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }
}
