//
//  HighlightedText.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 23.04.2025.
//

import SwiftUI

struct HighlightedText: View {
    let text: String
    let highlightedText: Dictionary<[String], any ShapeStyle>
    
    var body: some View {
        process()
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
                
                if let style {
                    result = result + spacer + Text(word).foregroundStyle(style).bold()
                } else {
                    result = result + spacer + Text(word)
                }
                
            }
            
        }
        return result
    }
}
