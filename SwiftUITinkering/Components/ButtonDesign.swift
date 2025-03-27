//
//  ButtonDesign.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 26.03.2025.
//

import SwiftUI

struct ButtonDesign: View {
    
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        Button {
            print("Button tapped")
        } label: {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.addButton)
                .frame(width: width, height: height)
                .rotationEffect(.degrees(45))
                .overlay {
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                        .scaleEffect(width / 30)
                }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ButtonDesign(width: 100, height: 100, cornerRadius: 20)
}
