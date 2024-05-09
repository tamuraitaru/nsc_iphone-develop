//
//  PryvacyPoicyView.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/03/26.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            WebView(urlString: URLConfiguration.privacyURL, showTabBar: true)
                .navigationBarTitle("プライバシーポリシー", displayMode: .inline)
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
    PrivacyPolicyView()
}
