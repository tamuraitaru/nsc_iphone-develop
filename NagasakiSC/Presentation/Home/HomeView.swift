//
//  HomeView.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/03/22.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            WebView(urlString: URLConfiguration.homeURL, showTabBar: true)
                .navigationBarTitle("ホーム", displayMode: .inline)
                .font(Font.custom("Hiragino Kaku Gothic ProN", size: 16).weight(.bold))
        }
    }
}
