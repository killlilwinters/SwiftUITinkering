//
//  HLBackgoundText.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 23.04.2025.
//

import SwiftUI

struct Highlight<Style: ShapeStyle>: TextAttribute {
    
    let id: UUID = UUID()
    let style: Style
    
    static func == (lhs: Highlight<Style>, rhs: Highlight<Style>) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

struct HLBackgroundText: View {
    
    let text: String
    let highlightedText: Dictionary<[String], any ShapeStyle>
    
    var body: some View {
        process().textRenderer(HighlightRenderer())
    }
    
    private func process() -> Text {
        guard !highlightedText.isEmpty && !text.isEmpty else {
            return Text(text)
        }
        
        var result = Text("")
        
        // 1. Split the raw string into lines (keeping empty lines)
        let lines = text.components(separatedBy: .newlines)
        
        // 2. Iterate lines & then words
        for (lineIndex, line) in lines.enumerated() {
            let words = line.components(separatedBy: " ")
            
            for (wordIndex, word) in words.enumerated() {
                // Determine spacer: newline at start of every line except the first,
                // space between words otherwise, nothing before the very first word.
                let spacer: Text = {
                    if lineIndex == 0 && wordIndex == 0 {
                        return Text("")
                    } else if wordIndex == 0 {
                        return Text("\n")
                    } else {
                        return Text(" ")
                    }
                }()
                
                // Look up a style for this word (case-insensitive)
                let style = highlightedText.first { pair in
                    pair.key.contains { $0.lowercased() == word.lowercased() }
                }?.value
                
                // Append styled or plain word
                if let gradient = style as? AnyGradient {
                    result = result + spacer + Text(word)
                        .customAttribute(Highlight(style: gradient))
                } else if let color = style as? Color {
                    result = result + spacer + Text(word)
                        .customAttribute(Highlight(style: color))
                } else {
                    result = result + spacer + Text(word)
                }
            }
        }
        
        return result
    }
    
    struct HighlightRenderer: TextRenderer {
        func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
            for line in layout {
                
                for run in line {
                    let context = ctx
                    let rect = Rectangle().path(in: run.typographicBounds.rect)
                    
                    if let highlight: Highlight<AnyGradient> = run[Highlight.self] {
                        print("AnyGradient")
                        context.fill(rect, with: .style(highlight.style.opacity(0.7)))
                    } else if let highlight: Highlight<Color> = run[Highlight.self] {
                        print("Color")
                        context.fill(rect, with: .style(highlight.style.opacity(0.7)))
                    }
                    context.draw(run)
                    
                }
                
            }
        }
        
        
    }
}
