//
//  NewsView.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/18.
//

import SwiftUI

struct NewsView: View {
    let notification: Notification
    @State private var image: Image = Image(systemName: "photo")

    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: notification.imageUrl ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 200)

                    // Category tags
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(notification.categories ?? [], id: \.id) { category in
                                Text(category.name)
                                    .font(.caption)
                                    .padding(.horizontal, 3)
                                    .padding(.vertical, 3)
                                    .background(RoundedRectangle(cornerRadius: 0)
                                        .fill(Color.white))
                                    .foregroundColor(.black)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 0)
                                            .stroke(Color.black, lineWidth: 1)
                                    )
                            }
                        }
                        .padding(.vertical)
                    }

                    // Headline
                    Text(notification.title)
                        .font(.title)
                        .padding(.bottom, 2)

                    // Date
                    HStack {
                        Spacer()
                        Text(formatDate(from: notification.termFrom))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 2)

                    // Body
                    Text(notification.topics)
                }
                .padding()
            }
            .onAppear {
                loadNewsImage()
            }
    }

    private func loadNewsImage() {
        // Load image from the notification.imageUrl
        // For now, we'll use a placeholder from assets
        self.image = Image("placeholderImage")
    }

    private func formatDate(from dateString: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")

            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "yyyy年M月d日 HH:mm"
                dateFormatter.locale = Locale(identifier: "ja_JP")
                return dateFormatter.string(from: date)
            }

            return dateString
        }
}

// Helper formatter for the date
extension Formatter {
    static func localizedString(from date: Date, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        return dateFormatter.string(from: date)
    }
}
