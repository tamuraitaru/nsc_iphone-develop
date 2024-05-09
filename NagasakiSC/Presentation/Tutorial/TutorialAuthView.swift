//
//  TutorialAuthView.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/15.
//

import SwiftUI

struct TutorialAuthView: View {
    @ObservedObject var viewModel = TutorialAuthViewModel()

    var body: some View {
        VStack {
            Spacer()
            NavigationLink(destination: AuthView(), isActive: $viewModel.isAuthViewActive) {
                EmptyView()
            }
            Button {
                viewModel.toLoginOrSignUpView()
            } label: {
                Text("ログイン or 新規登録")
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .frame(height: 48)
                    .background(Color.black)
                    .border(Color.black)
                    .cornerRadius(100)
            }
            NavigationLink(destination: NotificationPermissionView(), isActive: $viewModel.isNotificationPermissionViewActive) {
                EmptyView()
            }
            Button {
                //　ゲスト会員で利用する
                viewModel.guestLogin()
            } label: {
                Text("ゲスト会員で利用する")
                    .foregroundColor(Color.black)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .frame(height: 48)
                    .background(Color.white)
                    .border(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .padding(.top, 10)
                    .padding(.bottom, 16) // 画面の下から16pxの余白を追加
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TutorialAuthView()
}
