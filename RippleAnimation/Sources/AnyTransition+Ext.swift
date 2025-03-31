//
//  AnyTransition+Ext.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 31.03.2025.
//

import SwiftUI

public extension AnyTransition {
    static func ripple(location: CGPoint) -> AnyTransition {
        .asymmetric(
            insertion: .modifier(
                active: Ripple(location: location, isIdentity: false),
                identity: Ripple(location: location, isIdentity: true)
            ),
            removal: .modifier(
                active: IdentityTransitionDelay(opacity: 0.99),
                identity: IdentityTransitionDelay(opacity: 1)
            )
        )
    }
    
    static func reverseRipple(location: CGPoint) -> AnyTransition {
        .modifier(
            active: Ripple(location: location, isIdentity: false),
            identity: Ripple(location: location, isIdentity: true)
        )
    }
}
