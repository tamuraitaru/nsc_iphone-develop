//
//  ContentView.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/03/15.
//

import SwiftUI
import Combine
import Firebase

struct MainTabView: View {
    @ObservedObject var appState = AppState.shared
    @StateObject private var viewModel = MainTabViewModel(categoryService: CategoryService(apiService: APIForFV()))
    @State private var selectedTab = 0

    let persistenceController = PersistenceController.shared

    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        if selectedTab == 0 {
                            Image("tapped_home_Icon")
                        } else {
                            Image("home_Icon")
                        }
                        Text("ホーム")
                    }
                    .tag(0)
                EventView()
                    .tabItem {
                        if selectedTab == 1 {
                            Image("tapped_event_Icon")
                        } else {
                            Image("event_Icon")
                        }
                        Text("イベント")
                    }
                    .tag(1)
                NotificationTabView()
                    .tabItem {
                        if selectedTab == 2 {
                            Image("tapped_notification_Icon")
                        } else {
                            Image("notification_Icon")
                        }
                        Text("お知らせ")
                    }
                    .tag(2)
                if !appState.isAuthLogin {
                    GuestHotelLoginView()
                        .tabItem {
                            if selectedTab == 3 {
                                Image("tapped_hotel_Icon")
                            } else {
                                Image("hotel_Icon")
                            }
                            Text("ホテル予約")
                        }
                        .tag(3)
                } else {
                    Hotel()
                        .tabItem {
                            if selectedTab == 3 {
                                Image("tapped_hotel_Icon")
                            } else {
                                Image("hotel_Icon")
                            }
                            Text("ホテル予約")
                        }
                        .tag(3)
                }
                MyPageView()
                    .tabItem {
                        if selectedTab == 4 {
                            Image("tapped_mypage_Icon")
                        } else {
                            Image("mypage_Icon")
                        }
                        Text(AppState.shared.isAuthLogin ? "マイページ" : "会員登録")
                    }
                    .tag(4)
            }
            .accentColor(Color.fromHex("2B2B2B"))
            .navigationBarBackButtonHidden()
            .onAppear {
                // 初回起動時と7日ごとにFCMトークンを最新化する
                if isSevenDaysPassed() {
                    APIService().callFcmTokenAPI()
                }
                appState.isAuthLogin = UserDefaults.standard.bool(forKey: "auth_login")
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithDefaultBackground()
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                //       ゲストログイン時に呼ばれる 通常のタップで呼ばれるようにしましたが、それだと不具合が生じるためにここにしました。
                if !AppState.shared.isAuthLogin {
                    //              ゲストログインと関係なしに、ログインしたかどうかの関数
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    //              認証基盤ログインしたかどうかの関数
                    UserDefaults.standard.set(false, forKey: "auth_login")
                    callUserRegisterAPI()
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func isSevenDaysPassed() -> Bool {
        let savedTime = UserDefaults.standard.double(forKey: "FIRE_BASE_TOKEN_SAVE_TIME")
        // 初回起動時は呼ばれる
        if savedTime == 0.0 {
            print("◎初回:")
            saveFirstLaunchTime()
            return true
        }

        let currentTime = Date().timeIntervalSince1970 * 1000  // ミリ秒単位の現在時刻
        let sevenDaysInMillis: Double = 7 * 24 * 60 * 60 * 1000  // 7日間のミリ秒
        return (currentTime - savedTime * 1000) > sevenDaysInMillis
    }

    private func saveFirstLaunchTime() {
        // UserDefaultsに現在の時刻を保存する
        let currentTime = Date().timeIntervalSince1970
        UserDefaults.standard.set(currentTime, forKey: "FIRE_BASE_TOKEN_SAVE_TIME")
    }

    private func callUserRegisterAPI() {
        var cancellable = Set<AnyCancellable>()
        let url = URLConfiguration.signUpFV
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, _ in return data }
            .decode(type: UserRegisterAPIResponseEntity.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { complete in
                print(complete)
            } receiveValue: { response in
                saveToken(String(response.userId), forKey: "userId")
                print("userId: \(response.userId)")
            }
            .store(in: &cancellable)
    }
}

#Preview {
    MainTabView()
}
