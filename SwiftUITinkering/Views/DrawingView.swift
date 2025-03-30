//
//  DrawingView.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 27.03.2025.
//

import SwiftUI

struct DrawingView: View {
    
    @State private var path = Path()
    @State private var isDrawing = false
    
    func moveOrAddLine(_ newPoint: CGPoint) {
        if isDrawing {
            path.addLine(to: newPoint)
        } else {
            path.move(to: newPoint)
        }
    }
    
    var body: some View {
        Rectangle()
            .onAppear {
                path.move(to: CGPoint(x: 0, y: 0))
            }
            .gesture(
                DragGesture()
                    .onChanged{ value in
                        moveOrAddLine(value.location)
                        isDrawing = true
                    }
                    .onEnded{ value in
                        isDrawing = false
                    }
            )
            .overlay {
            path
                .stroke(.red, lineWidth: 3)
            }
    }
}

#Preview {
    DrawingView()
}
