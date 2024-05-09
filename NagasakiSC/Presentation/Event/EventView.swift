//
//  EventView.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/03/22.
//

import SwiftUI

struct EventView: View {
    var body: some View {
        NavigationView {
            WebView(urlString: URLConfiguration.eventURL, showTabBar: true)
                .navigationBarTitle("イベント", displayMode: .inline)
                .font(Font.custom("Hiragino Kaku Gothic ProN", size: 16).weight(.bold))
        }
    }
}
