//
//  WebViewModel.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/03/22.
//

import Foundation

class WebViewModel: ObservableObject {
    @Published var url: URL?
    @Published var showTabBar: Bool = true
    @Published var stateParameter: String?

    func loadWebPage(withURL urlString: String, stateParameter: String? = nil) {
        guard let url = URL(string: urlString) else {
            // Handle invalid URL
            return
        }
        self.url = url
        self.stateParameter = stateParameter
    }

    func setTabBarVisibility(_ visible: Bool) {
        showTabBar = visible
    }
}
