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
        guard !highlightedText.isEmpty && !text.isEmpty else { return Text(text) }
        
        var result = Text("")
        
        // Check for new lines and keep track of where they are
        var newLineIndexes: Set<Int> = .init()
        for (index, word) in text.components(separatedBy: .whitespaces).enumerated() {
            if word.contains("\n") {
                newLineIndexes.insert(index + 1)
            }
        }
        
        for (index, word) in text.components(separatedBy: .whitespacesAndNewlines).enumerated() {
            // Set a style intended for the current word (Optional<any ShapeStyle>)
            let style = highlightedText.first(where: {
                $0.key.contains { str in
                    str.lowercased() == word.lowercased()
                }
            })?.value
            
            // Insert an appropriate spacer based
            var spacer = Text(" ")
            if index == 0 {
                spacer = Text("")
            } else if newLineIndexes.contains(index) {
                spacer = Text("\n")
            }
            
            // Check if the style exists for this word
            // if it is nil - just insert the word with no effects
            guard let style else { result = result + spacer + Text(word); continue }
            
            // Type cast the style and apply it
            if let style = style as? AnyGradient {
                result = result + spacer + Text(word).customAttribute(Highlight(style: style))
            } else if let style = style as? Color {
                result = result + spacer + Text(word).customAttribute(Highlight(style: style))
            } else {
                result = result + spacer + Text(word)
            }
            
        }
        
        return result
    }
    
}

struct HighlightRenderer: TextRenderer {
    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        for line in layout {
            
            for run in line {
                let context = ctx
                let rect = Rectangle().path(in: run.typographicBounds.rect)
                
                if let highlight: Highlight<AnyGradient> = run[Highlight.self] {
                    context.fill(rect, with: .style(highlight.style.opacity(0.7)))
                } else if let highlight: Highlight<Color> = run[Highlight.self] {
                    context.fill(rect, with: .style(highlight.style.opacity(0.7)))
                }
                context.draw(run)
                
            }
            
        }
    }
    
    
}

