//
//  IdentityTransitionDelay.swift
//  MyPackage
//
//  Created by Maks Winters on 31.03.2025.
//

import SwiftUI

internal struct IdentityTransitionDelay: ViewModifier {
    var opacity: CGFloat
    
    func body(content: Content) -> some View {
        content
            .opacity(opacity)
    }
}
