//
//  NotificationPermissionView.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/14.
//

import Foundation
import SwiftUI

struct NotificationPermissionView: View {
    @StateObject var viewModel = NotificationPermissionViewModel()

    var body: some View {
        VStack {
            Spacer()
            Image("app_push")
                .resizable()
                .aspectRatio(2/3, contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - 16)
                .padding(.bottom, 16)
                .padding(.top, 16)
                .padding(.horizontal, 16)
            NavigationLink(destination: MainTabView(), isActive: $viewModel.isMainTabViewActive) {
                EmptyView()
            }
            Button {
                viewModel.showNotificationDialog()
            } label: {
                Text("次へ")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .frame(height: 48)
                    .background(Color.black)
                    .cornerRadius(100)
            }
            .padding(.top, 10)
            .padding(.bottom, 16)
        }
        .navigationBarBackButtonHidden()
    }
}

struct NotificationPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPermissionView()
    }
}
