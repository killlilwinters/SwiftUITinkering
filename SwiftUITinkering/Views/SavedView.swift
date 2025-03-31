//
//  SavedView.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 31.03.2025.
//

import SwiftUI

struct SavedView: View {
    @State private var to: CGFloat = 0
    @State private var fillTo: CGFloat = 0
    
    private var heart: some View {
        Heart()
            .trim(from: 0, to: to)
            .stroke(.heart, style: StrokeStyle(lineWidth: 3, lineCap: .round))
            .frame(width: 40, height: 40)
            .background {
                Heart()
                    .fill(.heart)
                    .opacity(fillTo)
            }
    }
    
    var body: some View {
        ZStack {
            Image(.turtlerock)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                heart
                
                Text("Saved.")
//                    .foregroundStyle(.white)
                    .opacity(to)
                    .blur(radius: 1 - to)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                let insertion: AnyTransition = .opacity.animation(.linear(duration: 0.3))
                let removal: AnyTransition = .opacity.animation(.linear(duration: 0.2).delay(0.7))
                if to == 1 {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundStyle(.ultraThinMaterial)
                        .transition(
                            .asymmetric(insertion: insertion, removal: removal)
                        )
                }
            }
        }
        .onTapGesture {
            animateHeart()
        }
    }
    
    func animateHeart() {
        let duration: CGFloat = 0.3
        let strokeAnimation: Animation = .easeIn(duration: duration).delay(duration)
        let fillAnimation: Animation = .linear(duration: duration).delay(duration)
        
        switch to {
        case 0:
            withAnimation(strokeAnimation) { to = 1 }
            withAnimation(fillAnimation) { fillTo = 1 }
        case 1:
            withAnimation(strokeAnimation) { to = 0 }
            withAnimation(fillAnimation) { fillTo = 0 }
        default:
            break
        }
    }
    
}

#Preview {
    SavedView()
}
