//
//  GradientView.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 01.04.2025.
//

import SwiftUI

struct GradientView: View {
    
    let color: Color
    
    var body: some View {
        Rectangle()
            .fill(color.gradient)
            .ignoresSafeArea()
    }
}

#Preview {
    GradientView(color: .blue)
}
