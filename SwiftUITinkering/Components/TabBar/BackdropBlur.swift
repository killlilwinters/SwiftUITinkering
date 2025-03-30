//
//  BackdropBlur.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 29.03.2025.
//

import UIKit
import SwiftUI

// MARK: - Backdrop Views
// https://stackoverflow.com/a/73950386
struct BackdropView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView()
        let blur = UIBlurEffect()
        let animator = UIViewPropertyAnimator()
        animator.addAnimations { view.effect = blur }
        animator.fractionComplete = 0
        animator.stopAnimation(false)
        animator.finishAnimation(at: .current)
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) { }
}

struct BackdropBlurView: View {
    let radius: CGFloat
    var body: some View {
        BackdropView().blur(radius: radius)
    }
}
