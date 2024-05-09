//
//  EditMemberInfoView.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/03/26.
//

import SwiftUI

struct EditMemberInfoView: View {
    private var key = retrieveToken(forKey: "user_id")

    var body: some View {

        WebView(urlString: URLConfiguration.contactURL, showTabBar: false)
            .toolbar {
                ToolbarItem(placement: .principal) { // Places content in the center of the navigation bar
                    Text("お問合せ")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EditMemberInfoView()
}
