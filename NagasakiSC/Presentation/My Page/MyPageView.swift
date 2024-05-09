//
//  MyPage.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/03/22.
//

import SwiftUI

struct MyPageView: View {
    @ObservedObject var appState = AppState.shared
    @State private var showingLogoutAlert = false
    @State private var isPrivacyPolicyPresented = false
    @State private var isOpenSourcePresented = false
    @State private var isTermOfServicePresented = false
    @State private var isHelpContactViewPresented = false
    @State private var isEditNotificationTitlePresented = false

    @StateObject private var viewModel = MypageViewModel()
    let apiService = APIForFV() // Assuming you instantiate it somewhere

//    private var categoryRepository = CategoryRepository()
    // 計算済みのプロパティとしてuserNameを宣言
    private var userName: String {
        if let retrievedName = retrieveToken(forKey: "userName") {
            if retrievedName == " " { return "" }
            return String(retrievedName + "様")
        } else {
            return ""
        }
    }
    var body: some View {
        VStack {
            Text(AppState.shared.isAuthLogin ? "マイページ" : "会員登録")
                .font(Font.custom("Hiragino Kaku Gothic ProN", size: 16).weight(.bold))
                .frame(width: UIScreen.main.bounds.width, height: 33)
            List {
                if !appState.isAuthLogin {
                    HStack {
                        Spacer()
                        Text(AppState.shared.isAuthLogin ? "\(userName)" : "ゲスト様")
                            .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .padding(.bottom, 20)
                    HStack {
                        Spacer()
                        Text("会員登録をすると\nさまざまな特典がご利用いただけます")
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                    .cornerRadius(20)

                    NavigationLink(destination: AuthView()) {
                        CustomBlackButton(title: "ログイン or 新規会員登録")
                            .padding(.leading, 18)
                    }
                    .cornerRadius(20)
                }
                Section(header: Text("設定").bold().font(.title2)) {
                    if appState.isAuthLogin {
                        Button("お知らせのカテゴリ設定") {
                            isEditNotificationTitlePresented = true
                        }
                        .sheet(isPresented: $isEditNotificationTitlePresented) {
                            EditNotificationTitleView(viewModel: EditNotificationTitleViewModel(apiService: apiService))
                        }
                        .listRowBackground(Color.clear)
                    } else {
                        Button("お知らせのカテゴリ設定") {
                            isEditNotificationTitlePresented = true
                        }
                        .sheet(isPresented: $isEditNotificationTitlePresented) {
                            EditNotificationTitleView(viewModel: EditNotificationTitleViewModel(apiService: apiService))
                        }
                        .listRowBackground(Color.clear)
                        .background(
                                Divider()
                                    .padding(.top, 40)
                                    .padding(.trailing, -20)
                        )
                    }

                    if appState.isAuthLogin {
                        NavigationButton {
                            showingLogoutAlert = true
                        } label: {
                            Text("ログアウト")
                                .foregroundColor(Color.black) // テキストの色を黒に設定
                        }
                        .listRowBackground(Color.clear)
                        .alert(isPresented: $showingLogoutAlert) {
                            Alert(
                                title: Text("ログアウト"),
                                message: Text("ログアウトしてよろしいですか。"),
                                primaryButton: .default(Text("ログアウト"), action: {
                                    //                                    ゲストログイン(ユーザーidを新規発行して、stadiumIdを空にする)
                                    viewModel.callUserRegisterAPI()
                                    saveToken("", forKey: "stadiumId")
                                    AppState.shared.isAuthLogin = false
                                    UserDefaults.standard.set(false, forKey: "auth_login")
                                }),
                                secondaryButton: .cancel(Text("戻る"))
                            )
                        }
                        .background(
                            Divider()
                                .padding(.top, 40)
                                .padding(.trailing, -350)
                        )
                    }
                }
                Section(header: Text("ヘルプ").bold().font(.title2)) {
                    NavigationButton {
                        isHelpContactViewPresented = true
                    } label: {
                        Text("お問い合わせ")
                    }
                    .sheet(isPresented: $isHelpContactViewPresented) {
                        HelpContactView() // モーダル表示されるViewを指定
                    }
                    .listRowBackground(Color.clear)
                    .background(
                        Divider()
                            .padding(.top, 40)
                            .padding(.trailing, -20)
                    )
                }
                Section(header: Text("情報").bold().font(.title2)) {
                    NavigationButton {
                        isTermOfServicePresented = true
                    } label: {
                        Text("利用規約")
                    }
                    .sheet(isPresented: $isTermOfServicePresented) {
                        TermsOfServiceView()
                    }
                    .listRowBackground(Color.clear) // ここで背景色を赤色に指定

                    NavigationButton {
                        isPrivacyPolicyPresented = true
                    } label: {
                        Text("プライバシーポリシー")
                    }
                    .sheet(isPresented: $isPrivacyPolicyPresented) {
                        PrivacyPolicyView()
                    }
                    .listRowBackground(Color.clear) // ここで背景色を赤色に指定

                    NavigationButton {
                        isOpenSourcePresented = true
                    } label: {
                        Text("オープンソースライセンス")
                    }
                    .sheet(isPresented: $isOpenSourcePresented) {
                        OpenSourceLicenseView()
                    }
                    .listRowBackground(Color.clear) // ここで背景色を赤色に指定

                    VStack(alignment: .leading) {
                        Text("運営会社").foregroundColor(.gray)
                        Text("株式会社リージョナルクリエーション長崎")
                    }
                    .listRowBackground(Color.clear) // ここで背景色を赤色に指定

                    VStack(alignment: .leading) {
                        Text("アプリバージョン").foregroundColor(.gray)
                        Text("1.0.0")
                    }
                    .listRowBackground(Color.clear) // ここで背景色を赤色に指定
                }
            }
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
