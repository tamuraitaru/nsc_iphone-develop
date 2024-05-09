//
//  ContentView.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/18.
//

//import SwiftUI

// struct ContentView: View {
//    var body: some View {
//        // Simulate a news object
//        let sampleNews = News(imageUrl: URL(string: "https://user0514.cdnw.net/shared/img/thumb/shikun103104_TP_V4.jpg")!,
//                              categories: ["ライブ", "フィギュアスケート"],
//                              headline: "〇〇グループ presents 『フィギュア・オン・アイス 2024』開催決定！今年も世界最高峰のアイスショーをお届けいたします。",
//                              date: Date(),
//                              body: "また、ゲストスケーターとして、山田香織選手の追加出演者が決定。さらには特別企画が決定！全公演の休憩中に、スペシャルトークショーの実施が決定し、横浜、大阪、九州公演では終演後、抽選で記念写真撮影にご参加いただけるスペシャルフォトセッションの実施も決定。日替わりでレギュラー・スケーターや世界選手権出場選手をはじめ今回の出演スケーターの中から参加していただきます。")
//        NewsView(news: sampleNews)
//    }
// }
//
//struct ContentView: View {
//    @State private var checkedItems: [String] = []
//    @State private var isAllChecked = false
//
//    let allItems = ["スタジアム", "アリーナ", "ホテル", "ショッピングモール", "オフィス", "イベント", "V・ファーレン長崎", "長崎ウェルカ", "レストラン", "グルメ・カフェ", "アミューズメント"]
//
//    var body: some View {
//        VStack {
//            HStack {
//                VStack(alignment: .leading, spacing: 10) {
//                    Text("お知らせに表示したい情報を選択してください。")
//                    Button(isAllChecked ? "すべてクリア" : "すべてを選択する") {
//                        isAllChecked.toggle()
//                        if isAllChecked {
//                            checkedItems = allItems
//                        } else {
//                            checkedItems = []
//                        }
//                    }
//                }
//                Spacer()
//            }
//            .padding(.horizontal)
//            
//            List {
//                ForEach(allItems, id: \.self) { item in
//                    HStack {
//                        Image(systemName: checkedItems.contains(item) ? "checkmark.square" : "square")
//                            .onTapGesture {
//                                if checkedItems.contains(item) {
//                                    checkedItems.removeAll(where: { $0 == item })
//                                } else {
//                                    checkedItems.append(item)
//                                }
//                            }
//                        Text(item)
//                    }
//                }
//            }
//
//            Button("この内容で登録") {
//                // Call API to update server with `checkedItems`
//                print("Registering checked items: \(checkedItems)")
//            }
//            .padding()
//            .foregroundColor(Color.white)
//            .frame(width: UIScreen.main.bounds.width - 40)
//            .frame(height: 48)
//            .background(Color.black) // ラベルの背景色を黒に設定
//            .border(Color.black)
//            .cornerRadius(100)
//        }
//        .padding(.bottom, 10)
//        .onAppear {
//            // Load initial checked items from server
//            checkedItems = ["スタジアム", "アリーナ", "イベント", "グルメ・カフェ"]
//        }
//    }
//}
import SwiftUI

struct ContentView: View {
    var notificationData: NotificationData = NotificationData(
        total: 2,
        notifications: [
            Notification(
                id: 1,
                title: "Notification 1",
                topics: "Topics 1",
                important: true,
                isRead: false,
                categories: [
                    Notification.Category(id: 1, name: "Category 1", order: 1),
                    Notification.Category(id: 2, name: "Category 2", order: 2)
                ],
                termFrom: "2023-05-01'T'00:00:00",
                imageUrl: "https://example.com/image1.jpg"
            ),
            Notification(
                id: 2,
                title: "Notification 2",
                topics: "Topics 2",
                important: false,
                isRead: true,
                categories: [
                    Notification.Category(id: 3, name: "Category 3", order: 3)
                ],
                termFrom: "2023-05-02'T'00:00:00",
                imageUrl: "https://example.com/image2.jpg"
            )
        ]
    )

    var body: some View {
        List(notificationData.notifications) { notification in
            NotificationView(notification: notification)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        let sampleNotificationData = NotificationData(
//            total: 2,
//            notifications: [
//                Notification(
//                    id: 1,
//                    title: "Notification 1",
//                    topics: "Topics 1",
//                    important: true,
//                    isRead: false,
//                    categories: [
//                        Notification.Category(id: 1, name: "Category 1", order: 1),
//                        Notification.Category(id: 2, name: "Category 2", order: 2)
//                    ],
//                    termFrom: "2023-05-01T00:00:00",
//                    imageUrl: "https://example.com/image1.jpg"
//                ),
//                Notification(
//                    id: 2,
//                    title: "Notification 2",
//                    topics: "Topics 2",
//                    important: false,
//                    isRead: true,
//                    categories: [
//                        Notification.Category(id: 3, name: "Category 3", order: 3)
//                    ],
//                    termFrom: "2023-05-02T00:00:00",
//                    imageUrl: "https://example.com/image2.jpg"
//                )
//            ]
//        )
//        
//        ContentView(notificationData: NotificationData)
//    }
//}
