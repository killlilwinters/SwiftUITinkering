//
//  RendererTestView.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 22.04.2025.
//

import SwiftUI

struct RendererTestView: View {
    
    let text = """
        This is a test text
        for testing the text renderer
    """
    
    let values = [
        ["Test"]: Color.blue.gradient,
        ["for", "a"]: Color.red.gradient
    ]
    
    var body: some View {
        HighlightedText(text: text, highlightedText: values)
    }
}

struct HighlightedText: View {
    
    let text: String
    let highlightedText: Dictionary<[String], any ShapeStyle>
    
    var body: some View {
        process()
    }
    
    func process() -> Text {
        guard !highlightedText.isEmpty && !text.isEmpty else { return Text("") }
        
        var result = Text("")
        
        for (index, word) in text.components(separatedBy: " ").enumerated() {
            let word = word.lowercased()
            let str = index == 0 ? word : " " + word
            
            let style = highlightedText.first(where: {
                $0.key.contains { str in
                    str.lowercased() == word
                }
            })?.value
            
            if let style {
                result = result + Text(str).foregroundStyle(style).bold()
            } else {
                result = result + Text(str)
            }
            
        }
        
        return result
    }
    
}

#Preview(traits: .sizeThatFitsLayout) {
    RendererTestView()
}
