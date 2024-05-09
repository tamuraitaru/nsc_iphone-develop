//
//  HotelView.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/03/22.
//

import SwiftUI

struct Hotel: View {
    let accessToken: String
    let idToken: String
    let refreshToken: String

    init() {
        self.accessToken = retrieveToken(forKey: accessTokenKeychainKey) ?? ""
        self.idToken = retrieveToken(forKey: idTokenKeychainKey) ?? ""
        self.refreshToken = retrieveToken(forKey: "refresh_token") ?? ""
    }

    var body: some View {
        var urlComponents = URLComponents(url: URL(string: URLConfiguration.hotelURL)!, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: accessToken),
            URLQueryItem(name: "id_token", value: idToken),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        return AnyView(NavigationView {
            if AppState.shared.isAuthLogin {
                WebView(urlString: urlComponents.url!.absoluteString, showTabBar: true, viewType: .hotel)
                    .navigationBarTitle("ホテル予約", displayMode: .inline)
                    .font(Font.custom("Hiragino Kaku Gothic ProN", size: 16).weight(.bold))
            } else {
                GuestHotelLoginView()
                    .navigationBarTitle("ホテル予約", displayMode: .inline)
                    .font(Font.custom("Hiragino Kaku Gothic ProN", size: 16).weight(.bold))
            }
        })
    }
}
