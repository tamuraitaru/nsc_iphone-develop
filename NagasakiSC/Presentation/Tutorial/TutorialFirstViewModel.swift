//
//  TutorialFirstViewModel.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/15.
//

import Foundation
import SwiftUI

class TutorialFirstViewModel: ObservableObject {
    @Published var isTutorialViewActive = false

    func toTutorialView() {
        isTutorialViewActive = true
    }
}
