//
//  TabBarFurtherTesting.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 29.03.2025.
//

import SwiftUI

struct TabBarFurtherTesting: View {
    var body: some View {
        TabView {
            Tab("Received", systemImage: "star") {
                Image(systemName: "Star")
                Text("Star")
            }
            .badge(10)
        }
    }
}

#Preview {
    TabBarFurtherTesting()
}
