//
//  ContentView.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 14.03.2025.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                NavigationLink("Tab bar", value: "TabBar")
                NavigationLink("Custom shapes", value: "CustomShapes")
                NavigationLink("Drawing", value: "DrawingView")
                NavigationLink("Nesting list rows", value: "NestingListRows")
            }
            .padding(.horizontal, 20)
            .navigationDestination(for: String.self) { string in
                switch string {
                case "TabBar":
                    TabBarExampleView()
                case "CustomShapes":
                    FrameTinkering()
                case "DrawingView":
                    DrawingView()
                case "NestingListRows":
                    NestingListRowsView()
                default:
                    Text("Unknown destination: \(string)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
