//
//  TabBarView.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 26.03.2025.
//

import SwiftUI

// MARK: - Preference Key for Tracking Button Frames
struct TabButtonFramePreferenceKey: PreferenceKey {
    static var defaultValue: [Int: CGRect] = [:]
    
    static func reduce(value: inout [Int: CGRect], nextValue: () -> [Int: CGRect]) {
        value.merge(nextValue()) { (_, new) in new }
    }
}

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

// MARK: - Tab Bar View
struct TabBarView: View {
    @State private var selectedItem: Int = 0
    
    @State private var zeroButton = false
    @State private var firstButton = false
    @State private var secondButton = false
    @State private var thirdButton = false
    
    @State private var buttonFrames: [Int: CGRect] = [:]
    
    private let width = UIScreen.main.bounds.width
    private let roundedRectangle = RoundedRectangle(cornerRadius: 45)
    
    private var circle: some View {
        Circle()
            .fill(.pink)
            .opacity(0.2)
            .scaleEffect(2)
            .frame(width: 30, height: 30)
    }
    
    var body: some View {
        ZStack {
            HStack {
                // Tab buttons
                makeButton("house", 0, variable: $zeroButton)
                Spacer()
                makeButton("checklist", 1, variable: $firstButton)
                Spacer()
                ButtonDesign(width: 55, height: 55, cornerRadius: 12)
                Spacer()
                makeButton("sparkles", 2, variable: $secondButton)
                Spacer()
                makeButton("gearshape", 3, variable: $thirdButton)
            }
            .frame(width: width * 0.8)
            .padding(.vertical, 15)
            .padding(.horizontal, 25)
            .background {
                ZStack {
                    
                    // Blur
                    // https://stackoverflow.com/a/62350667
                    BackdropBlurView(radius: 10)
                        .padding(-20)
                        .clipShape(roundedRectangle)
                    
                    // Dynamic circle positioned behind selected tab
                    circle
                        .position(
                            x: buttonFrames[selectedItem]?.midX ?? 0,
                            y: buttonFrames[selectedItem]?.midY ?? 0
                        )
                        .animation(.bouncy(duration: 0.25), value: selectedItem)
                }
            }
            .overlay {
                // Stroke
                roundedRectangle
                    .stroke(lineWidth: 1)
                    .fill(.tabBarBorder)
            }
        }
        .coordinateSpace(name: "TabBarZStack")
        .onPreferenceChange(TabButtonFramePreferenceKey.self) {
            buttonFrames = $0
        }
    }
    
    // Button factory method with frame tracking
    private func makeButton(_ systemImage: String, _ number: Int, variable: Binding<Bool>) -> some View {
        Button {
            withAnimation(.bouncy(duration: 0.25)) {
                selectedItem = number
                variable.wrappedValue.toggle()
            }
        } label: {
            labelFor(systemImage)
                .symbolEffect(.bounce.down.wholeSymbol, options: .nonRepeating, value: variable.wrappedValue)
                .symbolEffect(.bounce.down.wholeSymbol, options: .nonRepeating)
        }
        .buttonStyle(.plain)
        .background(
            GeometryReader { geometry in
                Color.clear
                    .preference(
                        key: TabButtonFramePreferenceKey.self,
                        value: [number: geometry.frame(in: .named("TabBarZStack"))]
                    )
            }
        )
    }
    
    private func labelFor(_ systemName: String) -> some View {
        Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .foregroundStyle(.pink)
    }
}

// MARK: - Preview
#Preview {
    TabBarView()
}
