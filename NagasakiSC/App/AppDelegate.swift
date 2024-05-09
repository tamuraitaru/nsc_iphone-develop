//
//  AppDelegate.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/22.
//

import UIKit
import Firebase
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Configure Firebase here
        FirebaseApp.configure()

        // デバイストークンの要求
        DispatchQueue.main.async(execute: {
            UIApplication.shared.registerForRemoteNotifications()
        })
        UNUserNotificationCenter.current().delegate = self
        // Cloud Messagingのデリゲート
        Messaging.messaging().delegate = self

        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("didRegisterForRemoteNotificationsWithDeviceToken")
        Messaging.messaging().apnsToken = deviceToken
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        let userInfo = notification.request.content.userInfo
        // Print full message.
        print(userInfo)

        guard let notification_id = userInfo["nagasaki_notification_id"] as? String else {
            return
        }

        print(notification_id)  // お知らせ対象のNotificationId
//        showNotificationDetail(notification_id: notification_id)

        // Change this to your preferred presentation option
        completionHandler([[.sound]])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        let userInfo = response.notification.request.content.userInfo
        // Print full message.
        print("---------------------")
        print("userInfo: \(userInfo)")
        print("---------------------")

        guard let notification_id = userInfo["nagasaki_notification_id"] as? String else {
            print("nagasaki_notification_id is nil")
            return
        }
        print("notification_id: \(notification_id)")  // お知らせ対象のNotificationId
//        showNotificationDetail(notification_id: notification_id)
//        UserDefaults.standard.set(notification_id, forKey: "notification_id")
//        showNotificationDetail(notification_id: "")
        completionHandler()
    }

//    func showNotificationDetail(notification_id: String) {
//        // 4をnotification_idにする
//        APIService().fetchNotificationDetails(id: "4") { result in
//            switch result {
//            case .success(let notificationDetail):
//                print("\(notificationDetail.title)")
//                let contentView = NewsView(notification: Notification(id: notificationDetail.id,
//                                                                      title: notificationDetail.title,
//                                                                      topics: notificationDetail.topics,
//                                                                      important: notificationDetail.important,
//                                                                      isRead: false,
//                                                                      categories: notificationDetail.categories.map { category in
//                    Notification.Category(id: category.id, name: category.name, order: category.order)
//                },
//                                                                      termFrom: notificationDetail.termFrom,
//                                                                      imageUrl: notificationDetail.imageUrl ?? ""))
//
//                DispatchQueue.main.async {
//                    if let window = UIApplication.shared.windows.first {
//                        let hostingController = UIHostingController(rootView: contentView)
//                        window.rootViewController = hostingController
//                        window.makeKeyAndVisible()
//                    }
//                }
//            case .failure(let error):
//                print("Failed to fetch notification details: \(error)")
//            }
//        }
//    }
}

extension AppDelegate: MessagingDelegate {
    // FCMトークンが利用可能になったり、更新されたりすると呼ばれる
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("===============")
        print("Firebase registration token: \(String(describing: fcmToken))")
        saveToken(fcmToken ?? "", forKey: "FCMToken")
        print("Firebase saveToken: \(String(describing: fcmToken))")
        print("===============")
    }
}
