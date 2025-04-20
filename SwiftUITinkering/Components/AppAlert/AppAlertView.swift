//
//  AppAlertView.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 18.04.2025.
//

import SwiftUI

struct AppAlertView: View {
    let haptics = try? HapticProvider()
    
    let role: AppAlertRole
    let title: String
    var subTitle: String?
    var cornerRadius: CGFloat = 20
    
    @State private var isUnfolded: Bool = false
    @State private var multiplier: CGFloat = 0
    
    @Binding var keep: Bool
    @Binding var isPresented: Bool
    
    var body: some View {
        let width: CGFloat = 320
        RoundedRectangle(cornerRadius: cornerRadius)
            .opacity(0.7)
            .frame(
                maxWidth:  isUnfolded ? width + (multiplier + 30) : width,
                maxHeight: isUnfolded ? (300 + multiplier)        : (60 + multiplier)
            )
            .overlay {
                contents
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        performOnDrag(value)
                    }
                    .onEnded { _ in
                        withAnimation(.bouncy) {
                            multiplier = 0
                        }
                    }
            )
            .onAppear(perform: performAppearanceHaptics)
            .onChange(of: isPresented) { $1 ? performAppearanceHaptics() : () }
            .onChange(of: isUnfolded) { _, _ in try? haptics?.performMediumTap() }
    }
    
    private func performAppearanceHaptics() {
        switch role {
        case .success: /*haptics?.performSuccess()*/ haptics?.perform(.success)
        case .warning: /*haptics?.performWarning()*/ haptics?.perform(.warning)
        case .error:   /*haptics?.performFailure()*/ haptics?.perform(.error)
        }
    }
    
    func performOnDrag(_ value: DragGesture.Value) {
        var statement = false
        if isUnfolded {
            
            statement = value.translation.height < multiplier && multiplier < -2
            
        } else {
            
            statement = value.translation.height > multiplier && multiplier > 3.2
            
        }
        
        if keep == isUnfolded {
            if statement {
                guard isPresented else { return }
                withAnimation(.bouncy) {
                    keep = !isUnfolded
                    isUnfolded = !isUnfolded
                }
            }
        }
        withAnimation(.bouncy) {
            multiplier = (value.translation.height / 80)
        }
        
    }
    
    @ViewBuilder
    var contents: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            Image(systemName: role.imageName)
                .foregroundStyle(role.color)
                .font(.system(
                    size: isUnfolded ? 50 : 30
                ))
                .position(
                    x: isUnfolded ? size.width / 2 : 30,
                    y: isUnfolded ? 50 : size.height / 2
                )
                .shadow(radius: 6)
                .animateSymbol(role: role)
            
            Text(title)
                .foregroundStyle(.background)
                .position(
                    x: size.width / 2,
                    y: isUnfolded ? 100 : size.height / 2
                )
            
            if let subTitle, isUnfolded {
                
                Text(subTitle)
                    .foregroundStyle(.background.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .frame(width: size.width - 20)
                    .position(
                        x: size.width / 2,
                        y: isUnfolded ? 200 : size.height / 2
                    )
                    .transition(.opacity)
                
            }
            
        }
    }
}

private extension View {
    @ViewBuilder
    func animateSymbol(role: AppAlertRole) -> some View {
        switch role {
        case .success: self.symbolEffect(.bounce, options: .nonRepeating)
        case .warning: self.symbolEffect(.pulse, options: .nonRepeating)
        case .error: self.symbolEffect(.wiggle, options: .nonRepeating)
        }
    }
}


#Preview {
    AppAlertView(role: .success, title: "Payment successful!", keep: .constant(false), isPresented: .constant(true))
}

#Preview("Landscape", traits: .landscapeRight) {
    AppAlertView(role: .error, title: "Payment failed.", keep: .constant(false), isPresented: .constant(true))
}
