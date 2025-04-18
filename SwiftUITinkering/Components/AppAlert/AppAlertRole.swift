//
//  AppAlertRole.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 18.04.2025.
//

import SwiftUI

enum AppAlertRole: String, CaseIterable {
    case success
    case warning
    case failure
    
    var color: Color {
        switch self {
        case .success: .success
        case .warning: .warning
        case .failure: .failure
        }
    }
    
    var imageName: String {
        switch self {
        case .success: "checkmark.circle"
        case .warning: "exclamationmark.triangle"
        case .failure: "xmark.circle"
        }
    }
}
