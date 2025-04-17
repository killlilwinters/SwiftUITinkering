//
//  AppAlert.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 16.04.2025.
//

import SwiftUI

enum AppAlertRole: String, CaseIterable {
    case success
    case warning
    case failure
    
    var color: Color {
        switch self {
        case .success: .green
        case .warning: .yellow
        case .failure: .red
        }
    }
    
    var imageName: String {
        switch self {
        case .success: "checkmark.circle"
        case .warning: "exclamationmark.triangle"
        case .failure: "xmark.circle"
        }
    }
}

struct AppAlert: ViewModifier {
    let role: AppAlertRole
    let title: String
    let subTitle: String?
    var cornerRadius: CGFloat = 20

    let disappearDelay: TimeInterval = 4

    @Binding var isPresented: Bool
    @State private var keep = false
    @State private var dismissWorkItem: DispatchWorkItem?

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .allowsHitTesting(!isPresented)
            .blur(radius: isPresented ? 5 : 0)
            .overlay {
                if isPresented {
                    VStack {
                        AppAlertView(role: role, title: title, subTitle: subTitle, keep: $keep, isPresented: $isPresented)
                        Spacer()
                    }
                    .transition(.move(edge: .top))
                    .animation(.easeInOut, value: isPresented)
                    .onAppear { scheduleDismissal() }
                    .onChange(of: role) { _, _ in scheduleDismissal() }
                    .onChange(of: isPresented) { _, presented in
                        if !presented {
                            dismissWorkItem?.cancel()
                        }
                    }
                    .onChange(of: keep) { oldValue, newValue in
                        scheduleDismissal()
                    }
                }
            }
    }

    private func scheduleDismissal() {
        // Cancel any pending dismissal
        dismissWorkItem?.cancel()

        // Create a new work item
        let workItem = DispatchWorkItem {
            guard !keep else { return }
            withAnimation {
                isPresented = false
            }
        }
        dismissWorkItem = workItem

        // Schedule it
        DispatchQueue.main.asyncAfter(deadline: .now() + disappearDelay, execute: workItem)
    }
}


struct AppAlertView: View {
    
    let role: AppAlertRole
    let title: String
    var subTitle: String?
    var cornerRadius: CGFloat = 20
    
    @State private var isUnfolded: Bool = false
    @State private var multiplier: CGFloat = 0 {
        didSet { print(multiplier) }
    }
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
//            .onTapGesture {
                //                keep.toggle()
                //                withAnimation(.bouncy) {
                //                    isUnfolded.toggle()
                //                }
//            }
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
            
            Text(title)
                .foregroundStyle(.white)
                .position(
                    x: size.width / 2,
                    y: isUnfolded ? 100 : size.height / 2
                )
            
            if let subTitle, isUnfolded {
                
                Text(subTitle)
                    .frame(width: size.width - 20)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .position(
                        x: size.width / 2,
                        y: isUnfolded ? 200 : size.height / 2
                    )
                    .transition(.opacity)
                
            }
            
        }
    }
}

#Preview {
    AppAlertView(role: .success, title: "Payment successful!", keep: .constant(false), isPresented: .constant(true))
}

#Preview("Landscape", traits: .landscapeRight) {
    AppAlertView(role: .failure, title: "Payment failed.", keep: .constant(false), isPresented: .constant(true))
}

#Preview("TestPreview") {
    AlertTestView()
}
