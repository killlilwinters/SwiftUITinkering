//
//  HeartShape.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 31.03.2025.
//
// https://stackoverflow.com/a/61323622 - Very curvy heart
//
// https://medium.com/@ganeshrajugalla/swiftui-heart-animation-with-shape-db2b2b5a5861
//

import SwiftUI

struct Heart: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY ))
        
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.height/4),
                      control1:CGPoint(x: rect.midX, y: rect.height) ,
                      control2: CGPoint(x: rect.minX, y: rect.midY) )
        
        
        path.addArc(center: CGPoint( x: rect.width/4,y: rect.height/4),
                    radius: (rect.width/4),
                    startAngle: Angle(radians: Double.pi),
                    endAngle: Angle(radians: 0),
                    clockwise: false)
        
        path.addArc(center: CGPoint( x: rect.width * 3/4,y: rect.height/4),
                    radius: (rect.width/4),
                    startAngle: Angle(radians: Double.pi),
                    endAngle: Angle(radians: 0),
                    clockwise: false)
        
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.height),
                      control1: CGPoint(x: rect.width, y: rect.midY),
                      control2: CGPoint(x: rect.midX, y: rect.height) )
        
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    Heart()
        .stroke(.red, lineWidth: 5)
        .frame(width: 300, height: 300)
}
