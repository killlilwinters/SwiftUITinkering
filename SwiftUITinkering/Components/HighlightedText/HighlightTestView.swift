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
    enum HighlightingMode { case word, highlight }
    
    let text = """
    This is a test text
    for testing the text renderer
    """
    
    let values: Dictionary<[String], any ShapeStyle> = [
        ["Test"]:     Color.blue.gradient,
        ["for", "a"]: Color.red.gradient,
        ["renderer"]: Color.green
    ]
    
    let mode: HighlightingMode
    
    var body: some View {
        switch mode {
        case .word: HighlightedText(text: text, highlightedText: values)
        case .highlight: HLBackgroundText(text: text, highlightedText: values)
        }
    }
}

#Preview("Word", traits: .sizeThatFitsLayout) {
    HighlightTestView(mode: .word)
}
#Preview("Background", traits: .sizeThatFitsLayout) {
    HighlightTestView(mode: .highlight)
}
