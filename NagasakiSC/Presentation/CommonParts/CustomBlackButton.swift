//
//  CustomNextButton.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/29.
//

import Foundation
import SwiftUI

struct CustomBlackButton: View {
    let title: String

    var body: some View {
        Text(title)
            .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
            .fontWeight(.semibold)
            .foregroundColor(Color.white)
            .frame(width: UIScreen.main.bounds.width - 40)
            .frame(height: 48)
            .background(Color.black) // ラベルの背景色を黒に設定
            .border(Color.black)
            .cornerRadius(100)
    }
}
