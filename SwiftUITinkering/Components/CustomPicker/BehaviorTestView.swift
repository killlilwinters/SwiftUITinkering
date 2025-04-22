//
//  BehaviorTestView.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 22.04.2025.
//

import SwiftUI

struct BehaviorTestView: View {
    
    var body: some View {
        Picker("Test", selection: .constant(1)) {
            Text("123")
            
        }
    }
}

#Preview {
    BehaviorTestView()
}
