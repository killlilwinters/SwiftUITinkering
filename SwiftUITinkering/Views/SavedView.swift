//
//  SavedView.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 31.03.2025.
//
// https://medium.com/@ganeshrajugalla/swiftui-heart-animation-with-shape-db2b2b5a5861
//

import SwiftUI

struct SavedView: View {
    @Environment(\.dismiss) var dismiss
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
        VStack(spacing: 20) {
            
            heart
            
            Text("SAVED")
                .bold()
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
        .onAppear {
            animateHeart()
        }
    }
    
    func animateHeart() {
        let duration: CGFloat = 0.3
        let strokeAnimation: Animation = .easeIn(duration: duration).delay(duration)
        let fillAnimation: Animation = .linear(duration: duration).delay(duration * 2)
        
        switch to {
        case 0:
            withAnimation(strokeAnimation) { to = 1 }
            withAnimation(fillAnimation) { fillTo = 1 }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                dismiss()
            }
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
