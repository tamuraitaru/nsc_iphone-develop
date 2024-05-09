//
//  CheckNewsView.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/26.
//

import SwiftUI

struct NewsCheckView: View {
    @State private var notifications: [Notification] = []
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack {
                if !notifications.isEmpty {
                    List(notifications) { notification in
                        VStack(alignment: .leading) {
                            AsyncImage(url: URL(string: notification.imageUrl ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 114, height: 64)
                            Text(notification.title)
                                .font(.headline)
                            Text("Created At: \(notification.termFrom)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                } else if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
            .navigationBarTitle("Notifications")
        }
        .onAppear {
            fetchNotifications()
        }
    }

    private func fetchNotifications() {
        let apiForFV = APIForFV()

        apiForFV.notificationsAPI { notificationData, error in
            if let error = error {
                // Handle the error
                DispatchQueue.main.async {
                    errorMessage = error.localizedDescription
                }
            } else if let notificationData = notificationData {
                // Update the notifications array with the received data
                DispatchQueue.main.async {
                    notifications = notificationData.notifications
                }
            }
        }
    }
}
