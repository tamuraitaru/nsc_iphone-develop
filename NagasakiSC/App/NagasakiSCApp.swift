//
//  NagasakiSCApp.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/03/15.
//

import SwiftUI

@main
struct NagasakiSCApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var appCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            appCoordinator.body
        }
    }
}

class AppCoordinator: ObservableObject {
    @Published var isActive = true
    var isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")

    var body: some View {
        Group {
            if isActive {
                SplashScreen(isSplashScreenActive: Binding(
                    get: { self.isActive },
                    set: { self.isActive = $0 }
                ))
            } else {
                if isLoggedIn {
//                    NewsCheckView()
//                    ContentView()
                    MainTabView()
                } else {
                    TutorialView()
                }
            }
        }.onAppear {
            print("isLoggedIn: \(self.isLoggedIn)")
        }
    }
}
