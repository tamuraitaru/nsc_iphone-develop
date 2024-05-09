//
//  PageView.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/03/18.
//

import SwiftUI

struct PageView: View {
    var page: Page

    var body: some View {
        if page.tag == 0 {
            ZStack {
                VStack {
                    Text("長崎\nスタジアムシティ\nアプリへようこそ")
                        .font(.custom("Hiragino Kaku Gothic Pro", size: 26))
                        .fontWeight(.semibold)
                        .lineSpacing(19)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 32)
                    Text("「長崎スタジアムシティアプリ」は\n最新情報をお届けし、ホテルやイベントなどの\n各サービスのご予約・決済ができるアプリです。")
                        .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14)
                        .weight(.light))
                        .lineSpacing(5)
                        .multilineTextAlignment(.center)
                }
            }
        } else {
            VStack(spacing: 10) {
                Image("\(page.imageUrl)")
                    .resizable()
                    .aspectRatio(contentMode: .fill) // 縦横比2:3に設定
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity) // 画像を親ビューいっぱいに広げる
                    .overlay(
                        Rectangle() // 角丸の枠線を追加
                            .stroke(Color.fromHex("E6E8ED"), lineWidth: 1) // 枠線の色と太さを設定
                    )
                    .background(.gray.opacity(0.10))
                    .padding(.horizontal, 8) // 左右に8ポイントの余白を追加
                    .padding(.top, 16)
                VStack {
                    Text("\(page.title)")
                        .font(.custom("Hiragino Kaku Gothic Pro", size: 16))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .lineSpacing(7)
                        .padding(.horizontal, 8) // 左右に8ポイントの余白を追加
                        .padding(.top, 20)
                    Text("\(page.description)")
                        .font(.custom("Hiragino Kaku Gothic Pro", size: 14))
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .lineSpacing(5)
                        .padding(.top, 16) // 上部に24pxの余白を追加
                        .padding([.leading, .trailing], 8)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    PageView(page: Page.samplePage)
}
