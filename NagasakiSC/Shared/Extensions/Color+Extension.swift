//
//  Color+Extension.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/25.
//
import SwiftUI

extension Color {
    static func fromHex(_ hex: String, alpha: Double = 1.0) -> Color {
        var hexNumber: UInt32 = 0
        let scanner = Scanner(string: hex)
        scanner.scanHexInt32(&hexNumber)

        let red = Double((hexNumber & 0xFF0000) >> 16) / 255.0
        let green = Double((hexNumber & 0x00FF00) >> 8) / 255.0
        let blue = Double((hexNumber & 0x0000FF)) / 255.0
        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}
