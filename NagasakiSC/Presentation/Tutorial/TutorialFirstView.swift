//
//  TutorialFirstView.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/15.
//

import SwiftUI

struct TutorialFirstView: View {
    @ObservedObject var viewModel = TutorialFirstViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Image("app_back")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    NavigationLink(destination: TutorialView(), isActive: $viewModel.isTutorialViewActive) {
                        EmptyView()
                    }
                    Button {
                        viewModel.toTutorialView()
                    } label: {
                        Text("次へ")
                            .foregroundColor(Color.white)
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .frame(height: 48)
                            .background(Color.black) // ラベルの背景色を黒に設定
                            .border(Color.black)
                            .cornerRadius(100)
                    }
                    Button("") {}
                        .hidden()
                        .foregroundColor(Color.black)
                        .frame(width: UIScreen.main.bounds.width - 40)
                        .frame(height: 48)
                        .background(Color.white)
                        .padding(.top, 10)
                        .padding(.bottom, 16) //
                }
            }
        }
    }
}

#Preview {
    TutorialFirstView()
}
