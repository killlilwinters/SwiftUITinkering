//
//  TabBarExampleView.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 30.03.2025.
//

import SwiftUI

struct TabBarExampleView: View {
    
    let overlayView = GradientView(color: .addButton)
    
    var body: some View {
        TabBarView(overlay: overlayView) {
            TabItemView(systemImage: "house") {
                Image(systemName: "house")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            TabItemView(systemImage: "checklist") {
                Image(systemName: "checklist")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
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
