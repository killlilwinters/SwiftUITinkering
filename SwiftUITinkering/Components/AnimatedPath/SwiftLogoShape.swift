//
//  SwiftLogo.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 01.04.2025.
//

import SwiftUI

struct SwiftLogo: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.69174*width, y: 0.78973*height))
        path.addCurve(to: CGPoint(x: 0.30409*width, y: 0.79427*height), control1: CGPoint(x: 0.58859*width, y: 0.84906*height), control2: CGPoint(x: 0.44677*width, y: 0.85516*height))
        path.addCurve(to: CGPoint(x: 0.03125*width, y: 0.56177*height), control1: CGPoint(x: 0.18856*width, y: 0.74533*height), control2: CGPoint(x: 0.0927*width, y: 0.65966*height))
        path.addCurve(to: CGPoint(x: 0.13203*width, y: 0.62295*height), control1: CGPoint(x: 0.06075*width, y: 0.58624*height), control2: CGPoint(x: 0.09516*width, y: 0.60583*height))
        path.addCurve(to: CGPoint(x: 0.53038*width, y: 0.62313*height), control1: CGPoint(x: 0.27938*width, y: 0.69172*height), control2: CGPoint(x: 0.4267*width, y: 0.68701*height))
        path.addCurve(to: CGPoint(x: 0.16398*width, y: 0.24361*height), control1: CGPoint(x: 0.38289*width, y: 0.51054*height), control2: CGPoint(x: 0.25738*width, y: 0.36352*height))
        path.addCurve(to: CGPoint(x: 0.11482*width, y: 0.17753*height), control1: CGPoint(x: 0.14431*width, y: 0.22403*height), control2: CGPoint(x: 0.12956*width, y: 0.19955*height))
        path.addCurve(to: CGPoint(x: 0.47122*width, y: 0.44675*height), control1: CGPoint(x: 0.22788*width, y: 0.28032*height), control2: CGPoint(x: 0.40732*width, y: 0.41002*height))
        path.addCurve(to: CGPoint(x: 0.2205*width, y: 0.13347*height), control1: CGPoint(x: 0.33605*width, y: 0.30479*height), control2: CGPoint(x: 0.2156*width, y: 0.12858*height))
        path.addCurve(to: CGPoint(x: 0.63346*width, y: 0.47122*height), control1: CGPoint(x: 0.43435*width, y: 0.34884*height), control2: CGPoint(x: 0.63346*width, y: 0.47122*height))
        path.addCurve(to: CGPoint(x: 0.64922*width, y: 0.48075*height), control1: CGPoint(x: 0.64005*width, y: 0.47492*height), control2: CGPoint(x: 0.64513*width, y: 0.478*height))
        path.addCurve(to: CGPoint(x: 0.66049*width, y: 0.44675*height), control1: CGPoint(x: 0.65353*width, y: 0.46983*height), control2: CGPoint(x: 0.65731*width, y: 0.4585*height))
        path.addCurve(to: CGPoint(x: 0.56954*width, y: 0.0625*height), control1: CGPoint(x: 0.6949*width, y: 0.32193*height), control2: CGPoint(x: 0.65558*width, y: 0.17997*height))
        path.addCurve(to: CGPoint(x: 0.83745*width, y: 0.59604*height), control1: CGPoint(x: 0.76863*width, y: 0.18242*height), control2: CGPoint(x: 0.88663*width, y: 0.40758*height))
        path.addCurve(to: CGPoint(x: 0.83327*width, y: 0.61107*height), control1: CGPoint(x: 0.83617*width, y: 0.60112*height), control2: CGPoint(x: 0.83478*width, y: 0.60614*height))
        path.addCurve(to: CGPoint(x: 0.89399*width, y: 0.84079*height), control1: CGPoint(x: 0.93158*width, y: 0.73345*height), control2: CGPoint(x: 0.90628*width, y: 0.86526*height))
        path.addCurve(to: CGPoint(x: 0.69174*width, y: 0.78973*height), control1: CGPoint(x: 0.84066*width, y: 0.73688*height), control2: CGPoint(x: 0.74193*width, y: 0.76865*height))
        path.closeSubpath()
        return path
    }
}

#Preview {
    SwiftLogo()
}
