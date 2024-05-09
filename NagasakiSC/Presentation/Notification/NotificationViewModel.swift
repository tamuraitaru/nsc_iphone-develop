//
//  NotificationViewModel.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/04.
//

import Foundation
import Combine

class NotificationViewModel: ObservableObject {
    @Published var response: MockCategoriesAPIResponseEntity = .init(categories: [])
    @Published var notificationResponse: NotificationAPIResponseEntity = .init(total: 0, notifications: [])
//  モックのURL
    private let url = "https://6ap0erlhcb.execute-api.ap-northeast-1.amazonaws.com/dev/categories"
//  自分宛お知らせ一覧
    private let notificationURL = "https://6ap0erlhcb.execute-api.ap-northeast-1.amazonaws.com/dev/notification?nip=50&nop=0"

    private var cancellable = Set<AnyCancellable>()
    private var notificationCancellable = Set<AnyCancellable>()

    init() {
        fetchCategoriesResponse()
        fetchNotificationResponse()
    }

    func fetchCategoriesResponse() {
        URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .tryMap { data, _ in return data }
            .decode(type: MockCategoriesAPIResponseEntity.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { complete in
                print(complete)
            } receiveValue: { [weak self] response in
                guard let self else { return }
                self.response = response
            }
            .store(in: &cancellable)
    }

    func fetchNotificationResponse() {
        URLSession.shared.dataTaskPublisher(for: URL(string: notificationURL)!)
            .tryMap { data, _ in return data }
            .decode(type: NotificationAPIResponseEntity.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { complete in
                print(complete)
            } receiveValue: { [weak self] response in
                guard let self else { return }
                self.notificationResponse = response
            }
            .store(in: &notificationCancellable)
    }
}
