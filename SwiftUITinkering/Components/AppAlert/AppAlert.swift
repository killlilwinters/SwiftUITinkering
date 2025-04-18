//
//  AppAlert.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 16.04.2025.
//

import SwiftUI

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
            .allowsHitTesting(!keep)
            .blur(radius: keep ? 5 : 0)
            .overlay {
                if isPresented {
                    VStack {
                        AppAlertView(role: role, title: title, subTitle: subTitle, keep: $keep, isPresented: $isPresented)
                        Spacer()
                    }
                    .transition(.move(edge: .top))
                    .animation(.easeInOut, value: isPresented)
                    .onAppear { scheduleDismissal() }
                    .onChange(of: role) { scheduleDismissal() }
                    .onChange(of: isPresented) { _, presented in
                        if !presented {
                            dismissWorkItem?.cancel()
                        } else {
                            scheduleDismissal()
                        }
                    }
                    .onChange(of: keep) { scheduleDismissal() }
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

#Preview("TestPreview") {
    AlertTestView()
}
