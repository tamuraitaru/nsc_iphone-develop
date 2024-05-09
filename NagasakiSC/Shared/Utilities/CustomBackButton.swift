//
//  CustomBackButton.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/14.
//

import Foundation
import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "")
                .padding(.horizontal, 20)
                .foregroundColor(.black)
        }
    }
}
