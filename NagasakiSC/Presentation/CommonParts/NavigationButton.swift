//
//  NavigationButton.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/29.
//

import Foundation
import SwiftUI

struct NavigationButton<T: View>: View {
    var action: () -> Void

    @ViewBuilder var label: () -> T

    var body: some View {
        Button(action: action) {
            NavigationLink(destination: EmptyView.init, label: label)
                .foregroundColor(Color(uiColor: .label))
        }
    }
}
