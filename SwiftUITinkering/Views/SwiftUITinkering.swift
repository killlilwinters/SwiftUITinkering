//
//  SwiftUITinkering.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 17.03.2025.
//

import SwiftUI

@MainActor
struct SwiftUITinkering: View {
    
    @ViewBuilder var body: TupleView<(
        
        Text?,
        
        VStack<TupleView<(
            Image,
            Text
        )>>,
        
        HStack<TupleView<(
            Button<Text>,
            Button<Text>
        )>>
        
    )> {
        
        ViewBuilder.buildIf(true ? Text("Hello") : nil)
        
        VStack(spacing: 15) {
            Image(systemName: "swift")
            Text("Hello SwiftUI!")
        }
        HStack {
            Button("OK") {  }
            Button("OK") {  }
        }
        
    }
    
}

#Preview {
    SwiftUITinkering()
}
