//
//  OpenSourceLicenseView.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/03/26.
//

import SwiftUI

struct OpenSourceLicenseView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    guard let url = URL(string: "https://github.com/firebase/firebase-ios-sdk") else { return }
                    UIApplication.shared.open(url)
                }) {
                    Text("Firebase 10.24.0 Apache 2.0")
                        .font(.system(size: 24))
                        .padding(.leading, 10)
                }
                Button(action: {
                    guard let url = URL(string: "https:github.com/auth0/JWTDecode.swift") else { return }
                    UIApplication.shared.open(url)
                }) {
                    Text("JWTDecode 3.1.0 Apache 2.0")
                        .font(.system(size: 24))
                        .padding(.leading, 10)
                }
                Spacer()
            }
            .navigationBarTitle("オープンソースライセンス", displayMode: .inline)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("cross_icon", bundle: nil)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
            )
        }
        .font(.system(size: 14, weight: .semibold))
    }
}

#Preview {
    OpenSourceLicenseView()
}
