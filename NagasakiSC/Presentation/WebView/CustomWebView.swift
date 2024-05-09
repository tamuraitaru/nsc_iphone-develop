//
//  CustomWebView.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/14.
//

import SwiftUI
import WebKit
import Combine
import JWTDecode

struct CustomWebView: UIViewRepresentable {
    @Binding var isPresented: Bool // 親Viewから渡される状態変数
    let url: URL
    let showTabBar: Bool
    var stateParameter: String?
    let viewType: ViewType?

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = .nonPersistent() // Use non-persistent data storage

        let webView = WKWebView(frame: .zero, configuration: config)
        // testFlightでの配信時にログイン画面のwebViewが表示されない不具合の対応
        if viewType == .auth {
            webView.scrollView.isScrollEnabled = false // スクロールを無効にする
        }
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = context.coordinator
        webView.customUserAgent = Constants.customUserAgent
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        // Create a local copy of URLComponents from the view's URL
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)

        // Safely add the state parameter if it exists
        if let state = stateParameter {
            if urlComponents?.queryItems == nil {
                urlComponents?.queryItems = []
            }
            urlComponents?.queryItems?.append(URLQueryItem(name: "state", value: state))
        }

        // Use the modified local copy to create the URLRequest
        if let urlWithParams = urlComponents?.url {
            let request = URLRequest(url: urlWithParams)
            webView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        // Dictionary mapping URLs to their credentials
        let parent: CustomWebView
        var cancellable = Set<AnyCancellable>()

        init(parent: CustomWebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            if parent.viewType == .hotel {
                if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodHTTPBasic {
                    let credentials = (username: "hotel_admin", password: "H0t3lOps2024")
                    let credential = URLCredential(user: credentials.username, password: credentials.password, persistence: .forSession)
                    completionHandler(.useCredential, credential)
                    print("Access with Basic authentication: \(String(describing: webView.url))")
                } else {
                    print("Failed with Basic authentication")
                    completionHandler(.performDefaultHandling, nil)
                }
            } else if parent.viewType == .terms {
                if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodHTTPBasic {
                    let credentials = (username: "pauth_admin", password: "prAthOps2024")
                    let credential = URLCredential(user: credentials.username, password: credentials.password, persistence: .forSession)
                    completionHandler(.useCredential, credential)
                    print("Access with Basic authentication: \(String(describing: webView.url))")
                } else {
                    print("Failed with Basic authentication")
                    completionHandler(.performDefaultHandling, nil)
                }
            } else {
                if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodHTTPBasic {
                    let credentials = (username: "auth_admin", password: "A0t3g70ps2024")
                    let credential = URLCredential(user: credentials.username, password: credentials.password, persistence: .forSession)
                    completionHandler(.useCredential, credential)
                    print("Access with Basic authentication: \(String(describing: webView.url))")
                } else {
                    print("Failed with Basic authentication")
                    completionHandler(.performDefaultHandling, nil)
                }
            }
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            guard let url = webView.url else {
                print("webView.url is nil")
                return
            }
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false), let queryItems = components.queryItems else {
                return
            }

            if parent.viewType == .auth {
                UserDefaults.standard.set(true, forKey: "auth_login")

                AppState.shared.isAuthLogin = UserDefaults.standard.bool(forKey: "auth_login")
                //          認証基盤ログイン時に行う関数
                handleAuthQueryItems(queryItems)
            }
        }

        func handleAuthQueryItems(_ queryItems: [URLQueryItem]) {
            var accessToken: String?
            var idToken: String?
            var refreshToken: String?
            for queryItem in queryItems {
                switch queryItem.name {
                case "access_token":
                    accessToken = queryItem.value
                    guard let unwrapAccessToken = accessToken else {
                        print("accessToken is nil")
                        return
                    }
                    saveToken(unwrapAccessToken, forKey: accessTokenKeychainKey)
//                    print("Access Token: \(unwrapAccessToken)")
                case "id_token":
                    idToken = queryItem.value
                    guard let unwrapIdToken = idToken else {
                        print("idToken is nil")
                        return
                    }
                    saveToken(unwrapIdToken, forKey: idTokenKeychainKey)
//                    print("unwrapIdToken: \(unwrapIdToken)")
//                  顧客基盤APIを呼ぶ
                    APIService().callGetdataAPI()
                case "refresh_token":
                    refreshToken = queryItem.value
                    guard let unwrapRefreshToken = refreshToken else {
                        print("refreshToken is nil")
                        return
                    }
                    saveToken(unwrapRefreshToken, forKey: "refresh_token")
//                    print("Refresh Token: \(unwrapRefreshToken)")
                default:
                    break
                }
            }
            parent.isPresented = true
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
        }
    }
}
