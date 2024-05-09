//
//  CustomDialogView.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/28.
//

import SwiftUI

struct CustomDialogView: View {
    var title: String
    var message: String
    var cancelTitle: String
    var confirmTitle: String
    var onCancel: () -> Void
    var onConfirm: () -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 20)

            Text(message)
                .foregroundColor(.gray)
                .padding([.leading, .trailing, .bottom], 20)

            HStack(spacing: 20) {
                Button(action: onCancel) {
                    Text(cancelTitle)
                        .foregroundColor(.blue)
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .cornerRadius(8)

                Button(action: onConfirm) {
                    Text(confirmTitle)
                        .foregroundColor(.blue)
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .cornerRadius(8)
            }
            .padding(.bottom, 20)
        }
        .background(Color(.systemGray6)) // This sets the background color to a system gray color
        .cornerRadius(12)
        .shadow(radius: 10)
        .padding([.leading, .trailing], 40) // Sets padding on the sides to match the dialog's width in the design
    }
}
