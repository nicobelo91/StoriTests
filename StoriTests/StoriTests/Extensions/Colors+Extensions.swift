//
//  Colors+Extensions.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 29/06/2024.
//

import SwiftUI

extension Color {
    
    init(hex: String) {
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int: UInt64 = 0
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (1, 1, 1, 0)
            }

            self.init(
                .sRGB,
                red: Double(r) / 255,
                green: Double(g) / 255,
                blue:  Double(b) / 255,
                opacity: Double(a) / 255
            )
        }
    
    //Shades of green
    static let themeDark: Color = Color(hex: "003A40")
    static let themePrimary: Color = Color(hex: "336166")
    static let themeGreen: Color = Color(hex: "66898C")
    static let themeGreen2: Color = Color(hex: "809DA0")
    static let themeSecondary: Color = Color(hex: "99B0B3")
    
    //Shades of gray
    static let background4: Color = Color(hex: "B3C4C6")
    static let background3: Color = Color(hex: "CCD8D9")
    static let background2: Color = Color(hex: "E6EBEC")
    static let background: Color = Color(hex: "F3F5F6")
    
}
