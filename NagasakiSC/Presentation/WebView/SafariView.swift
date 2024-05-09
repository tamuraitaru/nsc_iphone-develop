//
//  SafariView.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/03/22.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = context.coordinator
        return safariViewController
    }

    func updateUIViewController(
        _ uiViewController: SFSafariViewController,
        context: UIViewControllerRepresentableContext<SafariView>
    ) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, SFSafariViewControllerDelegate {
        let parent: SafariView

        init(parent: SafariView) {
            self.parent = parent
        }

        func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
            guard let components = URLComponents(url: URL, resolvingAgainstBaseURL: false), let queryItems = components.queryItems else {
                return
            }

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
                    saveToken(unwrapAccessToken, forKey: "accessToken")
                    print("Access Token: \(unwrapAccessToken)")
                case "id_token":
                    idToken = queryItem.value
                    guard let unwrapIdToken = idToken else {
                        print("idToken is nil")
                        return
                    }
                    saveToken(unwrapIdToken, forKey: "idToken")
                    print("ID Token: \(unwrapIdToken)")
                case "refresh_token":
                    refreshToken = queryItem.value
                    guard let unwrapRefreshToken = refreshToken else {
                        print("refreshToken is nil")
                        return
                    }
                    saveToken(unwrapRefreshToken, forKey: "refresh_token")
                    print("Refresh Token: \(unwrapRefreshToken)")
                default:
                    break
                }
            }
        }
    }
}
