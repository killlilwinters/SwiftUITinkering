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
        guard !highlightedText.isEmpty && !text.isEmpty else { return Text(text) }
        
        var result = Text("")
        
        for (index, word) in text.components(separatedBy: .whitespaces).enumerated() {
            let str = index == 0 ? word : " " + word
            
            let style = highlightedText.first(where: {
                $0.key.contains { str in
                    str.lowercased() == word.lowercased().trimmingCharacters(in: .newlines)
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
