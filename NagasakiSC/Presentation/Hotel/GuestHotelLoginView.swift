//
//  GuestHotelLoginView.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/24.
//

import SwiftUI

struct GuestHotelLoginView: View {

    init() {
        // ナビゲーションバーの外観をカスタマイズ
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.white // 背景色を白に設定
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black] // タイトルの色を黒に設定

        // すべてのナビゲーションバーにこの外観を適用
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                VStack {
                    Text("ホテル予約は、\nログインまたは会員登録が必要です。")
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 20)
                        .font(.custom("Hiragino Kaku Gothic Pro", size: 12)) // フォントとサイズを設定
                        .lineSpacing(11)
                    NavigationLink(destination: AuthView()) {
                        Text("ログイン or 新規会員登録")
                            .fontWeight(.semibold)
                            .font(.custom("Hiragino Kaku Gothic Pro", size: 14))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(25)
                    }
                    .padding(.horizontal, 16) // ボタンの横のパディングを16pxに設定
                    .padding(.bottom, 16) // ボタンの下に余白を追加
                }
                .background(Color.fromHex("FFFFFF")) // 白い背景を追加
                .cornerRadius(6) // 角を丸くする
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.fromHex("D5DADF"), lineWidth: 1) // 枠線の色と太さを設定
                )
                .padding(.horizontal, 16) // 水平方向のパディング
                .padding(.bottom, 16) // ボタンの下に余白を追加
                Spacer()
            }
            .background(Color.fromHex("F6F6F6"))  // ここで背景色を設定します。正確な色には修正が必要です。
            .navigationBarTitle("ホテル予約", displayMode: .inline)
            .font(Font.custom("Hiragino Kaku Gothic ProN", size: 16).weight(.bold))
        }
    }
}

#Preview {
    GuestHotelLoginView()
}
