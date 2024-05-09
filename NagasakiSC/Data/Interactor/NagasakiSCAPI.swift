//
//  NagasakiSCAPI.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/03/22.
//

import Foundation

struct NagasakiSCAPI {
    struct Header {
        //      全て仮の値を代入
        var contentType = "application/json"
//        var xUserId: String
//        var xApiKey = "WkFMQQ=="
//        var xAppHash = "99fb776d739bdd83353c123e46718bb88ee11d5e400e2ac68021e33a7d064d76"
    }

    //    下記お知らせAPIが完成次第実装
    struct UserRegister: RequestProtocol {
        typealias Response = UserRegisterAPIResponseEntity
        var path: String { APIClient.APIType.userRegister.path }
        var method: String { "POST" }
        var headers: [String: String]? = ["Content-Type": "application/json"]
        var body: Data?

        init(body: Data? = nil) {
            self.body = body
        }
    }

    struct UserChangeInfo: RequestProtocol {
        typealias Response = UserChangeInfoAPIResponseEntity

        var path: String { APIClient.APIType.userChangeInfo.path }
        var method: String { "POST" }
        var headers: [String: String]? = ["Content-Type": "application/json"]
        var body: Data?

        init(body: Data? = nil) {
            self.body = body
        }
    }

    struct UserGetInfo: RequestProtocol {
        typealias Response = UserGetInfoAPIResponseEntity

        var path: String { APIClient.APIType.userGetInfo.path }
        var method: String { "GET" }
        var headers: [String: String]? = ["Content-Type": "application/json"]
        var body: Data?

        init(body: Data? = nil) {
            self.body = body
        }
    }

    struct Categories: RequestProtocol {
        typealias Response = CategoriesAPIResponseEntity

        var path: String { APIClient.APIType.categories.path }
        var method: String { "GET" }
        var headers: [String: String]? = ["Content-Type": "application/json"]
        var body: Data?

        init(body: Data? = nil) {
            self.body = body
        }
    }

    struct CategoriesSetting: RequestProtocol {
        typealias Response = CategoriesSettingAPIResponseEntity

        var path: String { APIClient.APIType.categoriesSetting.path }
        var method: String { "GET" }
        var headers: [String: String]? = ["Content-Type": "application/json"]
        var body: Data?

        init(body: Data? = nil) {
            self.body = body
        }
    }

    struct CategoriesEdit: RequestProtocol {
        typealias Response = CategoriesEditAPIResponseEntity

        var path: String { APIClient.APIType.categoriesEdit.path }
        var method: String { "PUT" }
        var headers: [String: String]? = ["Content-Type": "application/json"]
        var body: Data?

        init(body: Data? = nil) {
            self.body = body
        }
    }

    struct FCMToken: RequestProtocol {
        typealias Response = FCMtokenAPIResponseEntity

        var path: String { APIClient.APIType.fcmToken.path }
        var method: String { "PUT" }
        var headers: [String: String]? = ["Content-Type": "application/json"]
        var body: Data?

        init(body: Data? = nil) {
            self.body = body
        }
    }

    struct Notification: RequestProtocol {
        typealias Response = NotificationAPIResponseEntity

        var path: String { APIClient.APIType.notification.path }
        var method: String { "GET" }
        var headers: [String: String]? = ["Content-Type": "application/json"]
        var body: Data?

        init(body: Data? = nil) {
            self.body = body
        }
    }

    struct NotificationDetail: RequestProtocol {
        typealias Response = NotificationDetailAPIResponseEntity

        var path: String { APIClient.APIType.notificationDetail.path }
        var method: String { "GET" }
        var headers: [String: String]? = ["Content-Type": "application/json"]
        var body: Data?

        init(body: Data? = nil) {
            self.body = body
        }
    }

    struct NotificationOpend: RequestProtocol {
        typealias Response = NotificationOpendAPIResponseEntity

        var path: String { APIClient.APIType.notificationOpend.path }
        var method: String { "PUT" }
        var headers: [String: String]? = ["Content-Type": "application/json"]
        var body: Data?

        init(body: Data? = nil) {
            self.body = body
        }
    }

    struct Mock: RequestProtocol {
        typealias Response = CategoriesAPIResponseEntity

        var path: String { APIClient.APIType.mock.apiPath }
        var method: String { "GET" }
        var header: [String: String]? = ["Content-Type": "application/json"]
        var body: Data?

        init(body: Data? = nil) {
            self.body = body
        }
    }
}
