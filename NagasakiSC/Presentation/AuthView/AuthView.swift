//
//  LoginView.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/13.
//

import SwiftUI

struct AuthView: View {
    var body: some View {
        WebView(urlString: URLConfiguration.loginURL, showTabBar: false, viewType: .auth)
            .navigationBarTitle("ログイン or 新規会員登録", displayMode: .inline)
            .navigationBarItems(leading: CustomBackButton())
    }
}

#Preview {
    AuthView()
}
