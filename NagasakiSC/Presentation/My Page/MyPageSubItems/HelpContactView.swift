//
//  HelpContactView.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/03/26.
//

import SwiftUI

struct HelpContactView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            WebView(urlString: URLConfiguration.contactURL, showTabBar: false)
                .navigationBarTitle("お問い合わせ", displayMode: .inline)
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
    }
}

#Preview {
    HelpContactView()
}
