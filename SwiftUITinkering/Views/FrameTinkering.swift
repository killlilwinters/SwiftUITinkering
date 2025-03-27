//
//  FrameTinkering.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 17.03.2025.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + (rect.width / 5), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - (rect.height / 5)))
        path.addLine(to: CGPoint(x: rect.maxX - (rect.width / 5), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Star: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        
        path.addLine(to: CGPoint(x: rect.minX + (rect.width / 2.6), y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + (rect.height / 3)))
        path.addLine(to: CGPoint(x: rect.minX + (rect.width / 3), y: rect.maxY / 2))
        path.addLine(to: CGPoint(x: rect.maxX / 5, y: rect.maxY - (rect.height / 5)))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - (rect.height / 2.5)))
        path.addLine(to: CGPoint(x: rect.maxX - (rect.width / 5), y: rect.maxY - (rect.height / 5)))
        path.addLine(to: CGPoint(x: rect.maxX - (rect.width / 3), y: rect.maxY / 2))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + (rect.height / 3)))
        path.addLine(to: CGPoint(x: rect.maxX - (rect.width / 2.6), y: rect.maxY / 3))

        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct FrameTinkering: View {
    var body: some View {
        VStack {
            Star()
                .frame(width: 200, height: 200)
                .foregroundStyle(.green)
                .frame(width: 350, height: 350)
                .overlay {
                    Star().stroke(Color.red, lineWidth: 5)
                }
            Arrow()
                .frame(width: 200, height: 200)
                .foregroundStyle(.blue)
        }
    }
}

#Preview {
    FrameTinkering()
}
