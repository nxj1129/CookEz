//
//  ColorExtension.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 12/5/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import SwiftUI

extension Color {
    static let lightBlue = Color("lightBlue")
    static let lightYellow = Color("lightYellow")
    static let bg1 = Color("BgColor1")
    static let bg2 = Color("BgColor2")
}

extension UIColor {
    static let tabBarColor = UIColor(red: 55.0/255.0, green: 131.0/255.0, blue: 222.0/255.0, alpha: 1.0)
}

extension View {
    public func gradientText(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
}

struct CustomGradient{
     static let mygradient = LinearGradient(gradient: .init(colors: [Color.bg1, Color.bg2]), startPoint: .leading, endPoint: .trailing)
}
