//
//  CustomBackViewButton.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/29.
//

import Foundation
import SwiftUI

struct CustomWhiteButton: View {
    let title: String

    var body: some View {
        Text(title)
            .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
            .fontWeight(.bold)
            .foregroundColor(Color.black)
            .frame(width: UIScreen.main.bounds.width - 40)
            .frame(height: 48)
            .background(Color.white) // ラベルの背景色を白に設定
            .border(Color.white)
            .cornerRadius(100)
    }
}
