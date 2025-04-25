//
//  HighlightTestView.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 22.04.2025.
//
// https://stackoverflow.com/a/74983148
//

import SwiftUI

struct HighlightTestView: View {

    
    static let linearGradient = AnyGradient(
        Gradient(stops: [
            Gradient.Stop(color: .red, location: 0),
            Gradient.Stop(color: .yellow, location: 1)
        ])
    )

    
    let text = """
    This is a test text
    
    for testing the text renderer
    
    
    Two empty lines testing
    """
    
    let values: Dictionary<[String], any ShapeStyle> = [
        ["Test"]:     Color.blue.gradient,
        ["for", "a"]: Color.red.gradient,
        ["renderer"]: Color.green,
        ["TESTING"]:  Self.linearGradient
    ]

    
    var body: some View {
        VStack(spacing: 50) {
            Text(text)
                .foregroundStyle(Self.linearGradient)
                .outline(title: "Original Text")
            HighlightedText(text: text, highlightedText: values)
                .outline(title: "HighlightedText")
            HLBackgroundText(text: text, highlightedText: values)
                .outline(title: "HLBackgroundText")
        }
    }
}

private struct Outline: ViewModifier {
    let title: String
    
    func body(content: Content) -> some View {
        content
            .overlay {
                Rectangle()
                    .stroke(Color.gray, lineWidth: 1)
                    .overlay {
                        GeometryReader { proxy in
                            Text(title)
                                .italic()
                                .bold()
                                .position(x: proxy.size.width / 2, y: -10)
                                .frame(width: proxy.size.width, height: proxy.size.height)
                        }
                    }
            }
    }
}

private extension View {
    func outline(title: String) -> some View {
        modifier(Outline(title: title))
    }
}

#Preview("Word", traits: .sizeThatFitsLayout) {
    HighlightTestView()
}
