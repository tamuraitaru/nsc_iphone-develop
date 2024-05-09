//
//  NotificationView.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/24.
//

import SwiftUI

struct NotificationView: View {
    let notification: Notification

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 16) {
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: URL(string: notification.imageUrl ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 114, height: 64)
                    if !notification.isRead {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                            .offset(x: 5, y: -5)
                    }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(notification.title)
                        .font(.headline)
                        .foregroundColor(notification.isRead ? .gray : .black)
                }
                Spacer()
            }
            Text("\(formatDate(stringDate: notification.termFrom))")
                .font(.caption)
                .foregroundColor(.gray)
            HStack {
                ForEach(notification.categories ?? [], id: \.id) { category in
                    Text(category.name.uppercased())
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 5)
                        .background(Color.white)
                        .foregroundColor(notification.important ? Color.red : Color.black)
                        .overlay(
                            Rectangle()
                                .stroke(notification.important ? Color.red : Color.black, lineWidth: 1)
                        )
                }
            }
        }
        .padding()
    }

    private func formatDate(stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" // Updated server date format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = dateFormatter.date(from: stringDate) {
            dateFormatter.dateFormat = "yyyy年M月d日 HH:mm" // Desired date format
            dateFormatter.locale = Locale(identifier: "ja_JP")
            return dateFormatter.string(from: date)
        } else {
            return stringDate
        }
    }
}
