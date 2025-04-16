//
//  AlertTestView.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 16.04.2025.
//

import SwiftUI

struct AlertTestView: View {
    @State var isPresented: Bool = false
    
    var body: some View {
        
        VStack {
            ZStack {
                Image(.turtlerock)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                Button("Test") {
                    withAnimation {
                        isPresented.toggle()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(
            AppAlert(
                role: .success,
                title: "Payment successful!",
                subTitle: "Payment\n\(UUID())\nwas successful!",
                isPresented: $isPresented
            )
        )
    }
}

#Preview {
    AlertTestView()
}
