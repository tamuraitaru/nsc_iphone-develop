//
//  CustomNavigationBarView.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/28.
//

import SwiftUI

struct CustomNavigationBarView: View {
    var title: String
    var rightIconName1: String?
    var rightIconName2: String?
    var rightAction1: (() -> Void)?
    var rightAction2: (() -> Void)?

    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
            }

            HStack {
                Spacer() // Pushes the icons to the edges
                // Right icons
                HStack(spacing: 3) {
                    if let rightIconName1 = rightIconName1, let action1 = rightAction1 {
                        Button(action: action1) {
                            Image(rightIconName1)
                                .foregroundColor(.black)
                        }
                    }
                    if let rightIconName2 = rightIconName2, let action2 = rightAction2 {
                        Button(action: action2) {
                            Image(rightIconName2)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
        .frame(height: 33) // Standard navigation bar height
        .background(Color.white)
        .padding(.horizontal) // This adds space on both sides of the ZStack
    }
}
