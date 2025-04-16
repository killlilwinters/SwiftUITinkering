//
//  AppAlert.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 16.04.2025.
//

import SwiftUI

enum AppAlertRole {
    case success, warning, failure
    
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
    
    let disappearDelay: Int = 4
    
    @Binding var isPresented: Bool
    @State private var keep = false
    
    func body(content: Content) -> some View {
        content
            .blur(radius: keep ? 5 : 0)
            .overlay {
                if isPresented {
                    VStack {
                        AppAlertView(role: role, title: title, subTitle: subTitle, keep: $keep)
                        Spacer()
                    }
                    .transition(. move(edge: .top))
                    .animation(.easeInOut, value: isPresented)
                    .onAppear {
                        Task {
                            try await Task.sleep(for: .seconds(disappearDelay))
                            guard !keep else { return }
                            withAnimation {
                                isPresented = false
                            }
                        }
                    }
                    .onChange(of: keep) {
                        Task {
                            try await Task.sleep(for: .seconds(disappearDelay))
                            guard !keep else { return }
                            withAnimation {
                                isPresented = false
                            }
                        }
                    }
                }
            }
    }
}

struct AppAlertView: View {
    
    let role: AppAlertRole
    let title: String
    var subTitle: String?
    
    @State private var isUnfolded: Bool = false
    @State private var multiplier: CGFloat = 0
    @Binding var keep: Bool
    
    var body: some View {
        let width: CGFloat = 320
//        var multiplier: CGFloat = 0
//        let height: CGFloat = isUnfolded ? 300 : 60 + multiplier
        RoundedRectangle(cornerRadius: 10)
            .opacity(0.7)
            .frame(
                maxWidth: isUnfolded ? width + 30 : width,
                maxHeight: isUnfolded ? 300 : 60 + multiplier
            )
            .overlay {
                contents
            }
            .onTapGesture {
                keep.toggle()
                withAnimation(.bouncy) {
                    isUnfolded.toggle()
                }
            }
            .gesture(
                DragGesture()
                    .onChanged{ value in
                        guard !isUnfolded else { return }
                        if keep == false {
                            keep.toggle()
                        }
                        print(multiplier)
                        multiplier = (value.translation.height / 100)
                    }
            )
            .onChange(of: multiplier) { oldValue, newValue in
                if newValue > 3.2 {
                    withAnimation(.bouncy) {
                        isUnfolded.toggle()
                        keep = true
                    }
                }
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
    AppAlertView(role: .success, title: "Payment successful!", keep: .constant(false))
}

#Preview("Landscape", traits: .landscapeRight) {
    AppAlertView(role: .failure, title: "Payment failed.", keep: .constant(false))
}

#Preview("TestPreview") {
    AlertTestView()
}
