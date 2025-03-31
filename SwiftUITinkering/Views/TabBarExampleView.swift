//
//  TabBarExampleView.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 30.03.2025.
//

import SwiftUI

struct TabBarExampleView: View {
    var body: some View {
        TabBarView {
            TabItemView(systemImage: "house") {
                Image(systemName: "house")
                    .resizable()
                    .scaledToFit()
            }
            TabItemView(systemImage: "checklist") {
                NestingListRowsView()
            }
            TabItemView(systemImage: "sparkles") {
                Text("Sparkles")
                    .font(.system(size: 36))
            }
            TabItemView(systemImage: "gearshape") {
                Image(.turtlerock)
                    .resizable()
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    TabBarExampleView()
}
