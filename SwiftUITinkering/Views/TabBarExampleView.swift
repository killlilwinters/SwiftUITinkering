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
                Image(systemName: "checklist")
                    .resizable()
                    .scaledToFit()
            }
            TabItemView(systemImage: "sparkles") {
                Text("Sparkles")
                    .font(.system(size: 36))
            }
            TabItemView(systemImage: "gearshape") {
                Text("Gearshape")
                    .font(.system(size: 36))
            }
        }
    }
}

#Preview {
    TabBarExampleView()
}
