//
//  MypageViewModel.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/24.
//

import Foundation
import Combine

class MypageViewModel: ObservableObject {
    private var cancellable = Set<AnyCancellable>()

    func callUserRegisterAPI() {
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
            } receiveValue: { [weak self] response in
                guard let self else { return }
                saveToken(String(response.userId), forKey: "userId")
                print("userId: \(response.userId)")
            }
            .store(in: &cancellable)
    }

}
