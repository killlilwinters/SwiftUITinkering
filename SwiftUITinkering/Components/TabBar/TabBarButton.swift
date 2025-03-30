//
//  TabBarButton.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 29.03.2025.
//

import SwiftUI

struct TabBarButton: View {
    
    let systemImage: String
    let buttonPosition: Int
    @Binding var selectedItem: Int
    
    @State private var animate = false
    
    init?(
        systemImage: String?,
        buttonPosition: Int?,
        selectedItem: Binding<Int>
    ) {
        guard systemImage != nil, buttonPosition != nil else { return nil }
        self.systemImage = systemImage!
        self.buttonPosition = buttonPosition!
        self._selectedItem = selectedItem
    }
    
    var body: some View {
        Button {
            withAnimation(.bouncy(duration: 0.25)) {
                selectedItem = buttonPosition
                animate.toggle()
            }
        } label: {
            labelFor(systemImage)
                .symbolEffect(.bounce.down.wholeSymbol, options: .nonRepeating, value: animate)
                .symbolEffect(.bounce.down.wholeSymbol, options: .nonRepeating)
        }
        .buttonStyle(.plain)
        .background(
            GeometryReader { geometry in
                Color.clear
                    .preference(
                        key: TabButtonFramePreferenceKey.self,
                        value: [buttonPosition: geometry.frame(in: .named("TabBarZStack"))]
                    )
            }
        )
    }
    
    private func labelFor(_ systemName: String) -> some View {
        Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .foregroundStyle(.pink)
    }
    
}

#Preview {
    TabBarButton(systemImage: "home", buttonPosition: 0, selectedItem: .constant(0))
}
