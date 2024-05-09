//
//  NotificationPermissionViewModel.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/14.
//

import UIKit
import UserNotifications
import FirebaseCore
import Firebase
import Combine

class NotificationPermissionViewModel: ObservableObject {
    @Published var isMainTabViewActive = false

    func showNotificationDialog() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]) { (granted, _) in
                if granted {
                    print("許可されました！")
                    self.registerForRemoteNotifications()
                } else {
                    print("拒否されました...")
                }
                DispatchQueue.main.async {
                    self.isMainTabViewActive = true
                }
            }
    }

    private func registerForRemoteNotifications() {
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                self.saveTokenToKeychain(token)
            }
        }
    }

    private func saveTokenToKeychain(_ token: String) {
        print("saveTokenToKeychain token: \(token)")
        saveToken(token, forKey: "FCMToken")
    }
}
