//
//  Page.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/03/18.
//

import Foundation

struct Page: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var description: String
    var imageUrl: String
    var tag: Int

    static var samplePage = Page(title: "Title Example", description: "This is a sample description for the purpose of debugging", imageUrl: "word", tag: 0)

    static var samplePages: [Page] = [
        Page(title: "", description: "", imageUrl: "", tag: 0),
        Page(title: "ホーム画面で施設情報をチェック！", description: "各施設ごとの特徴やトピックスなど\nさまざまな情報をアプリからご覧いただけます。", imageUrl: "tutorial_home", tag: 1),
        Page(title: "イベント情報の確認や予約ができる！", description: "イベントの最新情報はもちろん、\n予約・決済までをアプリで完結できます。", imageUrl: "tutorial_event", tag: 2)
,
        Page(title: "あなたが欲しい情報を\n厳選&最速でお知らせ！", description: "最新情報が受け取れるのはアプリ会員だけ。\n気になるカテゴリを自分でカスタマイズできます。", imageUrl: "tutorial_notification", tag: 3),
        Page(title: "ホテル情報のチェックや\n宿泊予約ができる！", description: "スタジアムシティホテル長崎のご予約ができます。", imageUrl: "tutorial_hotel", tag: 4),
        Page(title: "会員登録で\n予約入力がスムーズに！", description: "会員登録で、予約項目の入力が省略でき\nスムーズに予約をすることができます。", imageUrl: "tutorial_register", tag: 5),
        Page(title: "さあ、始めましょう！", description: "", imageUrl: "tutorial_start", tag: 6)
    ]
}
