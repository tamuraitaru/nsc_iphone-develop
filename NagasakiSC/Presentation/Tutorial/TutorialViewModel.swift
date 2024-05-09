//
//  TutorialViewModel.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/03/19.
//

import Foundation
import SwiftUI
import Combine
import JWTDecode

class TutorialViewModel: ObservableObject {
    @Published var currentPageIndex = 0
    @Published var isAuthViewActive = false

    @Published var response: UserRegisterAPIResponseEntity = .init(userId: 0)

    private var cancellable = Set<AnyCancellable>()

    func toAuthView() {
        isAuthViewActive = true
    }

    func callUserRegisterAPI() {
        let url = URLConfiguration.signUpFV
        print("\(url)")
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
            } receiveValue: { [weak self] response in
                guard let self else { return }
                self.response = response
                saveToken(String(response.userId), forKey: "userId")
                print("userId: \(response.userId)")
            }
            .store(in: &cancellable)
    }

    func incrementPage() {
        currentPageIndex += 1
    }

    func decrementPage() {
        currentPageIndex -= 1
    }
}
