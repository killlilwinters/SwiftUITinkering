//
//  AppAlertRole.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 18.04.2025.
//

import SwiftUI

enum AppAlertRole: String, CaseIterable {
    static var allCases: [AppAlertRole] = [.success, .warning, .error]
    
    case success
    case warning
    case error
    
    @available(*, unavailable, renamed: "error")
    case failure
    
    var color: Color {
        switch self {
        case .success:           .success
        case .warning:           .warning
        case .error, .failure:   .error
        }
    }
    
    var imageName: String {
        switch self {
        case .success:           "checkmark.circle"
        case .warning:           "exclamationmark.triangle"
        case .error, .failure:   "xmark.circle"
        }
    }
}
