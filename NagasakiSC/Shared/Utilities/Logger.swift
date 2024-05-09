//
//  Logger.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/05/01.
//

import Foundation
import OSLog

struct Logger {
    static let network = OSLog(subsystem: "jp.co.japanet.stadiumcityapp.dev", category: "network")
    static let presentation = OSLog(subsystem: "jp.co.japanet.stadiumcityapp.dev", category: "presentation")
}
