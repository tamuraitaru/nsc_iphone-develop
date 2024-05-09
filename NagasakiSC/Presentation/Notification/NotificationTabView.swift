//
//  NotificationTabView.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/03/22.
//

import SwiftUI
import Foundation
import OSLog

struct NotificationTabItem: Identifiable, Hashable, Decodable {
    let id: Int
    var name: String
    var notifications: [Notification]?  // Make notifications optional

    static func == (lhs: NotificationTabItem, rhs: NotificationTabItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct NotificationTabView: View {
    @StateObject var viewModel = NotificationTabViewModel()
    @State private var isFirstAppearance = true
    @State private var showAlert = false
    @State private var showEditNotificationSheet = false  // State to control sheet visibility
    @State private var currentIndex = 0
    @State private var offset: CGFloat = 0

    let apiService = APIForFV()

    var body: some View {
        VStack {
            CustomNavigationBarView(
                title: "お知らせ",
                rightIconName1: "mark_as_read",
                rightIconName2: "gear_for_category",
                rightAction1: {
                    showAlert = true
                    print("Left icon tapped")
                },
                rightAction2: {
                    showEditNotificationSheet = true  // Trigger navigation
                    print("Right icon tapped")
                }
            )
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("すべて既読"),
                    message: Text("すべてのメッセージを既読にしますか？"),
                    primaryButton: .default(Text("既読にする")) {
                        // Action when user confirms
                        showAlert = false
                    },
                    secondaryButton: .cancel(Text("キャンセル")) {
                        // Action when user cancels
                        showAlert = false
                    }
                )
            }

            NotificationTabBarView(categories: $viewModel.categories, selectedCategory: $viewModel.selectedCategory)

            GeometryReader { geometry in
                TabView(selection: $currentIndex) {
                    // "すべて" tab content
                    VStack {
                        if viewModel.allNotifications.isEmpty {
                            Text("No notifications available")
                                .frame(width: geometry.size.width, height: geometry.size.height)
                        } else {
                            ScrollView {
                                ForEach(viewModel.allNotifications, id: \.id) { notification in
                                    NavigationLink(destination: NewsView(notification: notification)) {
                                        NotificationView(notification: notification)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                    }
                    .tag(0)

                    // Category tabs content
                    ForEach(Array(viewModel.categories.enumerated()), id: \.offset) { index, category in
                        VStack {
                            if let notifications = category.notifications {
                                if notifications.isEmpty {
                                    VStack {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle())
#if DEBUG
                                        Text("DEBUG: No notifications available for \(category.name)")
                                            .frame(width: geometry.size.width, height: geometry.size.height)
#endif
                                    }
                                } else {
                                    ScrollView {
                                        ForEach(notifications, id: \.id) { notification in
                                            NavigationLink(destination: NewsView(notification: notification)) {
                                                NotificationView(notification: notification)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                }
                            } else {
                                VStack {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
#if DEBUG
                                    Text("DEBUG: Loading notifications for \(category.name)...")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
#endif
                                }
                                .frame(width: geometry.size.width, height: geometry.size.height)
                            }
                        }
                        .tag(index + 1)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onChange(of: currentIndex) { newIndex in
                    if newIndex == 0 {
                        viewModel.selectedCategory = nil
                        viewModel.fetchNotifications()
                    } else if newIndex - 1 < viewModel.categories.count {
                        let category = viewModel.categories[newIndex - 1]
                        viewModel.selectedCategory = category
                        viewModel.fetchNotifications(forCategoryID: category.id)
                    }
                }
            }
        }
        .onAppear {
            if isFirstAppearance {
                showEditNotificationSheet = true
                isFirstAppearance = false
            }
            viewModel.fetchCategories {
                viewModel.fetchNotifications()
            }
        }
        .onChange(of: viewModel.selectedCategory) { newValue in
            if let category = newValue {
                let index = viewModel.categories.firstIndex(where: { $0.id == category.id })
                if let index = index {
                    currentIndex = index + 1
                }
            } else {
                currentIndex = 0
            }
        }
        .sheet(isPresented: $showEditNotificationSheet) {
            EditNotificationTitleView(viewModel: EditNotificationTitleViewModel(apiService: apiService))
        }
    }
}

struct NotificationTabBarView: View {
    @Binding var categories: [NotificationTabItem]
    @Binding var selectedCategory: NotificationTabItem?

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 4)
                .foregroundColor(.black)
                .zIndex(1)

            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        Text("すべて")
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .foregroundColor(selectedCategory == nil ? .black : .white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(selectedCategory == nil ? Color.white : Color.black)
                            .onTapGesture {
                                selectedCategory = nil
                            }

                        ForEach(categories) { category in
                            Text(category.name)
                                .font(.system(size: 16, weight: .semibold, design: .default))
                                .foregroundColor(selectedCategory == category ? .black : .white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .background(selectedCategory == category ? Color.white : Color.black)
                                .id(category.id)
                                .onTapGesture {
                                    selectedCategory = category
                                    os_log("Category tapped: %{PUBLIC}@", log: Logger.presentation, type: .info, String(category.id))
                                }
                        }
                    }
                    .padding(.horizontal, 16)
                    .background(Color.black)
                    .onChange(of: selectedCategory) { newValue in
                        if let category = newValue {
                            withAnimation {
                                proxy.scrollTo(category.id, anchor: .center)
                            }
                        } else {
                            withAnimation {
                                proxy.scrollTo(0, anchor: .leading)
                            }
                        }
                    }
                }
            }
        }
    }
}
