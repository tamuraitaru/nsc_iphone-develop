//
//  WebView.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/11.
//

import SwiftUI

struct WebView: View {
    @StateObject private var webViewModel = WebViewModel()
    @State private var isChildViewPresented = false
    let urlString: String
    let showTabBar: Bool
    var stateParameter: String?
    let viewType: ViewType?

    init(urlString: String, showTabBar: Bool, stateParameter: String? = nil, viewType: ViewType? = nil) {
        self.urlString = urlString
        self.showTabBar = showTabBar
        self.stateParameter = stateParameter
        self.viewType = viewType
    }

    var body: some View {
        VStack {
            if let url = webViewModel.url {
                CustomWebView(isPresented: $isChildViewPresented, url: url, showTabBar: showTabBar, stateParameter: webViewModel.stateParameter, viewType: viewType)
            } else {
                Text("No URL loaded")
            }
        }
        .onAppear {
            webViewModel.loadWebPage(withURL: urlString, stateParameter: stateParameter)
            webViewModel.setTabBarVisibility(showTabBar)
        }
        NavigationLink(
            destination: UserDefaults.standard.bool(forKey: "isLoggedIn") ? AnyView(MainTabView()) : AnyView(NotificationPermissionView()),
            isActive: $isChildViewPresented
        ) {
            EmptyView()
        }

    }
}

enum ViewType {
    case hotel
    case auth
    case userInfo // 会員情報変更URLに合わせた命名にしました
    case home
    case event
    case contact
    case terms
    case privacy
}
