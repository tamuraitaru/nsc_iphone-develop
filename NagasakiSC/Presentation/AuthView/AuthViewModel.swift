//
//  LoginViewModel.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/13.
//

import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isAuthWebViewActive = false

    func showAuthWebView() {
        isAuthWebViewActive = true
    }
}
