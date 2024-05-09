//
//  APIService.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/18.
//

import Foundation
import JWTDecode

class APIService {

    func callGetdataAPI() {
        let url = URLConfiguration.getDataURL

        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }

        guard let idToken = retrieveToken(forKey: "IDToken") else {
            print("idToken is nil")
            return
        }

        guard let jwt = try? decode(jwt: idToken), let phoneNumber = jwt.body["phone_number"] else {
            return
        }

        let requestData = ["PHONE_NUMBER": phoneNumber]
        let jsonData = try? JSONSerialization.data(withJSONObject: requestData)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        // Authorization ヘッダーを設定。
        request.setValue("\(String(describing: idToken))", forHTTPHeaderField: "Authorization")
        request.setValue("\(Constants.customUserAgent)", forHTTPHeaderField: "User-Agent")

        let delegate = MySessionDelegate()
        let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: OperationQueue.main)
//   エラーの原因を返す処理を記述しています。正常系が返ってくるときだと邪魔なのでコメントアウトしておきます
//        let taskerror = session.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error: \(error)")
//            } else if let data = data, let responseString = String(data: data, encoding: .utf8) {
//                print("Response taskerror: \(responseString)")
//            }
//        }
//        taskerror.resume()

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                print("API request failed:", error?.localizedDescription ?? "Unknown error")
                return
            }

            print("callGetdataAPI Response status code:", httpResponse.statusCode)

            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode([GetDataAPIResponseAPIEntity].self, from: data)
                // API通信が成功した場合の処理
                saveToken(String(responseData.first?.stadiumNo ?? ""), forKey: "stadiumId")
                saveToken(String(responseData.first?.surname ?? "") + " " +  String(responseData.first?.givenName ?? ""), forKey: "userName")
                print("stadiumId: \(String(describing: responseData.first?.stadiumNo ?? ""))")
            } catch {
                print("Failed to decode response data:", error)
            }
            // 自身のユーザー情報取得APIを叩く
            self.callUserGetInfoAPI()
        }
        task.resume()
    }

    func callUserRegisterAPI() {
        let url = URLConfiguration.signUpFV
        print("url: \(url)")
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
//    エラーの原因を返す処理を記述しています。正常系が返ってくるときだと邪魔なのでコメントアウトしておきます
//        let delegate = MySessionDelegate()
//        let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: OperationQueue.main)
//
//        let taskerror = session.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error: \(error)")
//            } else if let data = data, let responseString = String(data: data, encoding: .utf8) {
//                print("Response taskerror: \(responseString)")
//            }
//        }
//        taskerror.resume()

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                print("API request failed:", error?.localizedDescription ?? "Unknown error")
                return
            }

            print("callUserRegisterAPI Response status code: \(httpResponse.statusCode)")

            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(UserRegisterAPIResponseEntity.self, from: data)
//                print("Response data:", responseData)
                // API通信が成功した場合の処理
                saveToken(String(responseData.userId), forKey: "userId")
                print("userId: \(responseData.userId)")
            } catch {
                print("Failed to decode response data:", error)
            }
            self.callUserChangeInfoAPI()
        }.resume()
    }

    func callUserChangeInfoAPI() {
        let url = URLConfiguration.signInFV
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }

        guard let userId = retrieveToken(forKey: "userId") else {
            print("userId is nil")
            return
        }

        guard let stadiumId = retrieveToken(forKey: "stadiumId") else {
            print("stadiumId is nil")
            return
        }

        print("UserChangeInfoAPIResponseEntity stadiumId: \(stadiumId)")

        let requestData = ["stadium_id": stadiumId]
        let jsonData = try? JSONSerialization.data(withJSONObject: requestData)

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = jsonData

        // Authorization ヘッダーを設定
        guard let authorizationHeader = encryptJSON(userId: userId, stadiumId: stadiumId) else { return }
        request.setValue("\(String(describing: authorizationHeader))", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//     エラーの原因を返す処理を記述しています。正常系が返ってくるときだと邪魔なのでコメントアウトしておきます
//        let delegate = MySessionDelegate()
//        let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: OperationQueue.main)
//
//        let taskerror = session.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error: \(error)")
//            } else if let data = data, let responseString = String(data: data, encoding: .utf8) {
//                print("Response taskerror: \(responseString)")
//            }
//        }
//        taskerror.resume()

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                print("API request failed:", error?.localizedDescription ?? "Unknown error")
                return
            }

            print("callUserChangeInfoAPI Response status code:", httpResponse.statusCode)

            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(UserChangeInfoAPIResponseEntity.self, from: data)
//                print("Response data:", responseData)
                // API通信が成功した場合の処理
                print("stadiumId: \(String(describing: responseData.stadiumId))")
                saveToken(String(responseData.stadiumId ?? ""), forKey: "stadiumId" )
                print("userId: \(String(describing: responseData.userId))")
                saveToken(String(responseData.userId ?? 0), forKey: "userId")
            } catch {
                print("Failed to decode response data:", error)
            }
        }
        task.resume()
    }
//    自身のユーザー情報取得
    func callUserGetInfoAPI() {
        let url = URLConfiguration.ownInfoFV
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }

        guard let stadiumId = retrieveToken(forKey: "stadiumId") else {
            print("stadiumId is nil")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Authorization ヘッダーを設定
        guard let authorizationHeader = encryptJSON(userId: "", stadiumId: stadiumId) else { return }
        request.setValue("\(String(describing: "\(authorizationHeader)"))", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//  エラーの原因を返す処理を記述しています。正常系が返ってくるときだと邪魔なのでコメントアウトしておきます
//        let delegate = MySessionDelegate()
//        let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: OperationQueue.main)
//
//        let taskerror = session.dataTask(with: request) { data, _, error in
//            if let error = error {
//                print("Error: \(error)")
//            } else if let data = data, let responseString = String(data: data, encoding: .utf8) {
//                print("Response taskerror: \(responseString)")
//            }
//        }
//        taskerror.resume()

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                print("API request failed:", error?.localizedDescription ?? "Unknown error")
                return
            }

            print("callUserGetInfoAPI Response status code: \(httpResponse.statusCode)")
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(UserGetInfoAPIResponseEntity.self, from: data)
                print("Response data:", responseData)
                // API通信が成功した場合の処理
                print("userId: \(String(describing: responseData.userId))")
                print("stadiumId: \(String(describing: responseData.stadiumId))")
//                ユーザーidが帰ってこない場合、ユーザー登録APIを呼び出してユーザーidをもらう
                if responseData.userId == nil {
                    self.callUserRegisterAPI()
                } else {
                    print("responseData.userId: \(responseData.userId ?? 0)")
                    saveToken(String(responseData.userId ?? 0), forKey: "userId")
                    saveToken(String(responseData.stadiumId ?? ""), forKey: "stadiumId")
                }
            } catch {
                print("Failed to decode response data:", error)
            }
        }.resume()
    }

    func callFcmTokenAPI() {
        var stadiumId: String = ""

        let url = URLConfiguration.fcmTokenLFV
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }

        guard let userId = retrieveToken(forKey: "userId") else {
            print("userId is nil")
            return
        }

        guard let fcmToken = retrieveToken(forKey: "FCMToken") else {
            print("fcmToken is nil")
            return
        }

        if AppState().isAuthLogin {
            stadiumId = retrieveToken(forKey: "stadiumId") ?? ""
        } else {
            stadiumId = ""
        }

        let requestData = ["fcm_token": fcmToken]
        let jsonData = try? JSONSerialization.data(withJSONObject: requestData)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData

        // Authorization ヘッダーを設定
        guard let authorizationHeader = encryptJSON(userId: userId, stadiumId: stadiumId) else { return }
        request.setValue("\(String(describing: authorizationHeader))", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//      エラーの原因を返す処理を記述しています。正常系が返ってくるときだと邪魔なのでコメントアウトしておきます
//        let delegate = MySessionDelegate()
//        let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: OperationQueue.main)
//
//        let taskerror = session.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error: \(error)")
//            } else if let data = data, let responseString = String(data: data, encoding: .utf8) {
//                print("callFcmTokenAPI Response taskerror: \(responseString)")
//            }
//        }
//        taskerror.resume()

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                print("API request failed:", error?.localizedDescription ?? "Unknown error")
                return
            }

            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(FCMtokenAPIResponseEntity.self, from: data)
                print("fcm_token: \(String(describing: responseData.fcmToken))")
            } catch {
                print("Failed to decode response data:", error)
            }
            print("callFcmTokenAPI Response status code:", httpResponse.statusCode)
        }
        task.resume()
    }

//    func fetchNotificationDetails(id: String, completion: @escaping (Result<NotificationDetail, Error>) -> Void) {
//        let path = "/notification/\(id)"
//        getRequest(path: path, requiresAuthorization: false) { (result: Result<NotificationDetail, Error>) in
//            switch result {
//            case .success(let notificationDetail):
//                completion(.success(notificationDetail))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
}
