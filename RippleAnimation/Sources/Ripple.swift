//
//  Ripple.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 31.03.2025.
//

import SwiftUI

internal struct Ripple: ViewModifier {
    var location: CGPoint
    var isIdentity: Bool
    
    func body(content: Content) -> some View {
        content
            .mask {
                MakeShape()
                    .ignoresSafeArea()
            }
        
    }
    
    private func MakeShape() -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            let progress: CGFloat = isIdentity ? 1 : 0
            let defaultScale = progress
            
            let circleSize: CGFloat = 50
            let circleRaduis: CGFloat = circleSize / 2
            
            let fillCircleScale: CGFloat = max(size.width / circleRaduis, size.height / circleRaduis) + 4
            
            ZStack(alignment: .center) {
                Circle()
                    .frame(width: circleSize, height: circleSize)
                
                ForEach(0..<3) { i in
                    let i = i + 1
                    let padding = CGFloat(i * 10)
                    
                    Circle()
                        .frame(
                            width: circleSize + padding,
                            height: circleSize + padding
                        )
                        .blur(radius: i < 2 ? 3 : 7)
                }
                
            }
            .frame(width: circleSize, height: circleSize)
            .compositingGroup()
            .scaleEffect(defaultScale + (fillCircleScale * progress), anchor: .center)
            .offset(x: location.x - circleRaduis, y: location.y - circleRaduis)
        }
    }
}

#Preview {
    @Previewable
    @State var isPresented: Bool = false
    
    @Previewable
    @State var overlayRippleLocation: CGPoint = .zero
    
    let rectangle = RoundedRectangle(cornerRadius: 30)
    
    rectangle
        .fill(.blue.gradient)
        .overlay(alignment: .center) {
            GeometryReader { proxy in
                let frame = proxy.frame(in: .global)
                
                Button {
                    overlayRippleLocation = .init(x: frame.midX, y: frame.midY)
                    
                    withAnimation(.easeInOut(duration: 0.55)) {
                        isPresented.toggle()
                    }
                } label: {
                    Circle()
                        .fill(.white)
                        .overlay(Image(systemName: "checkmark"))
                }
                .frame(width: 80, height: 80)
                .position(x: frame.width / 2, y: frame.height / 2)
                .buttonStyle(.plain)
            }
        }
        .overlay {
            if isPresented {
                rectangle
                    .fill(.red.gradient)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.55)) {
                            isPresented.toggle()
                        }
                    }
                    .transition(.reverseRipple(location: overlayRippleLocation))
            }
        }
}
