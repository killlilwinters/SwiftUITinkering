//
//  ContentView.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 14.03.2025.
//

import SwiftUI
import RippleAnimation

struct ContentView: View {
    
    @State private var isSavedPresented = false
    @State private var isAlertPresented = false
    
    @State private var selectedRole: AppAlertRole = .success
    var title: String {
        switch selectedRole {
        case .success:
            "Payment successful!"
        case .warning:
            "Something went wrong..."
        case .failure:
            "Insufficient funds!"
        }
    }
    let subTitle = "Info for\n\(UUID())"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
//                NavigationLink("Saved", value: "SavedView")
                Button("Saved") { isSavedPresented.toggle() }
                NavigationLink("Tab bar", value: "TabBar")
                NavigationLink("Custom shapes", value: "CustomShapes")
                NavigationLink("Drawing", value: "DrawingView")
                NavigationLink("Nesting list rows", value: "NestingListRows")
                NavigationLink("Alert test", value: "AlertTestView")
                HStack {
                    Button("Show alert") {
                        withAnimation {
                            isAlertPresented.toggle()
                        }
                    }
                    .allowsHitTesting(!isAlertPresented)
                    Picker("Pick a type", selection: $selectedRole) {
                        ForEach(AppAlertRole.allCases, id: \.rawValue) { c in
                            Text(c.rawValue.capitalized).tag(c)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .modifier(
                AppAlert(
                    role: selectedRole,
                    title: title,
                    subTitle: subTitle,
                    cornerRadius: 20,
                    isPresented: $isAlertPresented
                )
            )
            .navigationDestination(for: String.self) { string in
                switch string {
                case "SavedView":
                    SavedView()
                case "TabBar":
                    TabBarExampleView()
                case "CustomShapes":
                    FrameTinkering()
                case "DrawingView":
                    DrawingView()
                case "NestingListRows":
                    NestingListRowsView()
                case "AlertTestView":
                    AlertTestView()
                default:
                    Text("Unknown destination: \(string)")
                }
            }
            .fullScreenCover(isPresented: $isSavedPresented) {
                SavedView()
            }
        }
    }
}

#Preview {
    ContentView()
}
