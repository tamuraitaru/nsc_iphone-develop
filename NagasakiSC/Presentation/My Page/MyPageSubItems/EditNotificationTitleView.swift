//
//  EditNotificationTitleView.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/03/26.
//

import SwiftUI

struct EditNotificationTitleView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: EditNotificationTitleViewModel
    @State private var showingDiscardAlert = false

    var body: some View {
        NavigationView {
            VStack {
                CustomNavigationBarView(
                    title: "お知らせのカテゴリ設定",
                    rightIconName1: "cross_icon",
                    rightAction1: {
                        if viewModel.hasUnsavedChanges {
                            showingDiscardAlert = true
                        } else {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                )

                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("お知らせに表示したい情報を選択してください。")
                        Button(viewModel.isAllSelected ? "すべてクリア" : "すべてを選択する") {
                            viewModel.toggleAllSelection()
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                List(viewModel.categories) { category in
                    Button(action: {
                        viewModel.toggleSelection(for: category.id)
                    }
                    ) {
                        HStack {
                            Image(systemName: category.isSelected ? "checkmark.square" : "square")
                            Text(category.category.name)
                            Spacer()
                        }
                    }
                    .foregroundColor(.black)
                }

                Button("この内容で登録") {
                    viewModel.saveChanges()
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .foregroundColor(Color.white)
                .frame(width: UIScreen.main.bounds.width - 40)
                .frame(height: 48)
                .background(Color.black)
                .border(Color.black)
                .cornerRadius(100)

                Spacer()
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $showingDiscardAlert) {
            Alert(
                title: Text("確認"),
                message: Text("変更内容は保存されません。\n 設定画面を閉じますか？"),
                primaryButton: .default(Text("閉じる")) {
                    self.presentationMode.wrappedValue.dismiss()
                },
                secondaryButton: .cancel(Text(LocalizedStringKey("キャンセル")))
            )
        }
    }
}
