//
//  URLConfiguration.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/11.
//

import Foundation

struct URLConfiguration {
    #if DEBUG
    static let configuration = "DEBUG"
    // webViewの開発環境
    // URLs for Debug
    static let baseURL = "https://www.nagasakistadiumcity.com"
    // Home
    static let homeURL = "\(baseURL)/app"
    // Event
    static let eventURL = "\(baseURL)/app/event"
    // Contact
    static let contactURL = "\(baseURL)/contact"
    // Hotel Reservation
    static let hotelURL = "https://test-hotel.nagasakistadiumcity.com/login"
    // Login and Sing-up
    static let loginURL = "https://test-basis.nagasakistadiumcity.com/idp/Authorize.html"
    // User Info
    static let usrInfoURL = "https://test-basis.nagasakistadiumcity.com/idp/UserInfo.html"
    // Terms and Conditions
    static let termsURL = "https://basis.nagasakistadiumcity.com/idp/terms.html"
    // Privacy Policy
    static let privacyURL = "https://www.japanet.co.jp/shopping/i/sp/StadiumCityApp/privacy.html"
    // getDataのURL
    static let getDataURL = "https://tjszh4xmp7.execute-api.ap-northeast-1.amazonaws.com/stg/getdata"
    // FV開発環境(dev)
    // FV API
    static let baseURLFV = "https://d38erep2zx5w1s.cloudfront.net/dev/api/v1"
    // FV ユーザー登録
    static let signUpFV = "\(baseURLFV)/user"
    // FV ユーザー情報変更
    static let signInFV = "\(baseURLFV)/user"
    // FV 自身のユーザー情報取得
    static let ownInfoFV = "\(baseURLFV)/user"
    // FV カテゴリ一覧取得
    static let categoriesFV = "\(baseURLFV)/categories"
    // FV 選択中カテゴリ一覧取得
    static let categorySettingFV = "\(baseURLFV)/categories/setting"
    // FV カテゴリ編集
    static let categoryEditFV = "\(baseURLFV)/categories"
    // FV FCMトークン最新化
    static let fcmTokenLFV = "\(baseURLFV)/fcmtoken"
    // FV 自分宛お知らせ一覧
    static let notificationsFV = "\(baseURLFV)/notification"
    // FV お知らせ詳細
    static let notificationDetailsFV = "\(baseURLFV)/notification/"
    // FV お知らせ開封通知
    static let readNotification = "\(baseURLFV)/notification/:notification_id"
    #elseif STAGING
    static let configuration = "STAGING"
    // webViewの開発環境
    // URLs for Debug
    static let baseURL = "https://www.nagasakistadiumcity.com"
    // Home
    static let homeURL = "\(baseURL)/app"
    // Event
    static let eventURL = "\(baseURL)/app/event"
    // Contact
    static let contactURL = "\(baseURL)/contact"
    // Hotel Reservation
    static let hotelURL = "https://test-hotel.nagasakistadiumcity.com/login"
    // Login and Sing-up
    static let loginURL = "https://test-basis.nagasakistadiumcity.com/idp/Authorize.html"
    // User Info
    static let usrInfoURL = "https://test-basis.nagasakistadiumcity.com/idp/UserInfo.html"
    // Terms and Conditions
    static let termsURL = "https://basis.nagasakistadiumcity.com/idp/terms.html"
    // Privacy Policy
    static let privacyURL = "https://www.japanet.co.jp/shopping/i/sp/StadiumCityApp/privacy.html"
    // getDataのURL
    static let getDataURL = "https://tjszh4xmp7.execute-api.ap-northeast-1.amazonaws.com/stg/getdata"

    // JH開発環境(stg)
    // FV API
    static let baseURLFV = "https://test-app.nagasakistadiumcity.com/stage/api/v1"
    // FV ユーザー登録
    static let signUpFV = "\(baseURLFV)/user"
    // FV ユーザー情報変更
    static let signInFV = "\(baseURLFV)/user"
    // FV 自身のユーザー情報取得
    static let ownInfoFV = "\(baseURLFV)/user"
    // FV カテゴリ一覧取得
    static let categoriesFV = "\(baseURLFV)/categories"
    // FV 選択中カテゴリ一覧取得
    static let categorySettingFV = "\(baseURLFV)/categories/setting"
    // FV カテゴリ編集
    static let categoryEditFV = "\(baseURLFV)/categories"
    // FV FCMトークン最新化
    static let fcmTokenLFV = "\(baseURLFV)/fcmtoken"
    // FV 自分宛お知らせ一覧
    static let notificationsFV = "\(baseURLFV)/notification"
    // FV お知らせ詳細
    static let notificationDetailsFV = "\(baseURLFV)/notification/"
    // FV お知らせ開封通知
    static let readNotification = "\(baseURLFV)/notification/:notification_id"
    #else
    static let configuration = "RELEASE"
    // webViewの本番環境
    // URLs for Release
    static let baseURL = "https://www.nagasakistadiumcity.com"
    // Home
    static let homeURL = "\(baseURL)/app"
    // Event
    static let eventURL = "\(baseURL)/app/event"
    // Contact
    static let contactURL = "\(baseURL)/contact"
    // Hotel Reservation
    static let hotelURL = "https://hotel.nagasakistadiumcity.com/login"
    // Login and Sing-up
    static let loginURL = "https://basis.nagasakistadiumcity.com/idp/Authorize.html"
    // User Info
    static let usrInfoURL = "https://basis.nagasakistadiumcity.com/idp/UserInfo.html"
    // Terms and Conditions
    static let termsURL = "https://basis.nagasakistadiumcity.com/idp/terms.html"
    // Privacy Policy
    static let privacyURL = "https://www.japanet.co.jp/shopping/i/sp/StadiumCityApp/privacy.html"
    // getDataのURL
    static let getDataURL = "https://fz1k61hj5j.execute-api.ap-northeast-1.amazonaws.com/prod/getdata"
    // 本番環境(prod)
    // FV API
    static let baseURLFV = "https://app.nagasakistadiumcity.com/prod/api/v1"
    // FV ユーザー登録
    static let signUpFV = "\(baseURLFV)/user"
    // FV ユーザー情報変更
    static let signInFV = "\(baseURLFV)/user"
    // FV 自身のユーザー情報取得
    static let ownInfoFV = "\(baseURLFV)/user"
    // FV カテゴリ一覧取得
    static let categoriesFV = "\(baseURLFV)/categories"
    // FV 選択中カテゴリ一覧取得
    static let categorySettingFV = "\(baseURLFV)/categories/setting"
    // FV カテゴリ編集
    static let categoryEditFV = "\(baseURLFV)/categories"
    // FV FCMトークン最新化
    static let fcmTokenLFV = "\(baseURLFV)/fcmtoken"
    // FV 自分宛お知らせ一覧
    static let notificationsFV = "\(baseURLFV)/notification"
    // FV お知らせ詳細
    static let notificationDetailsFV = "\(baseURLFV)/notification/:notification_id"
    // FV お知らせ開封通知
    static let readNotification = "\(baseURLFV)/notification/:notification_id"

    #endif
}
