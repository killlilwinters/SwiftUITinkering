//
//  NestingListRowsView.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 22.03.2025.
//

import SwiftUI
import Foundation

private struct SpaceObject: Hashable, Identifiable {
    let id: UUID = UUID()
    let systemImage: String
    let name: String
    let color: Color
    let objects: [SpaceObject]?
    
    init(
        systemImage: String,
        name: String,
        color: Color,
        objects: [SpaceObject]? = nil
    ) {
        self.systemImage = systemImage
        self.name = name
        self.color = color
        self.objects = objects
    }
}

struct NestingListRowsView: View {
    
    private let milkyWaySystems: [SpaceObject] = [
        SpaceObject(
            systemImage: "circle.dotted",
            name: "Solar System",
            color: .primary,
            objects: [
                SpaceObject(systemImage: "sun.min.fill", name: "Sun", color: .yellow),
                SpaceObject(systemImage: "circle.fill", name: "Mercury", color: .gray),
                SpaceObject(systemImage: "circle.fill", name: "Venus", color: .orange),
                SpaceObject(systemImage: "circle.fill", name: "Earth", color: .blue, objects: [
                    SpaceObject(systemImage: "moon.fill", name: "Moon", color: .gray)
                ]),
                SpaceObject(systemImage: "circle.fill", name: "Mars", color: .red, objects: [
                    SpaceObject(systemImage: "moon.fill", name: "Phobos", color: .gray),
                    SpaceObject(systemImage: "moon.fill", name: "Deimos", color: .gray)
                ]),
                SpaceObject(systemImage: "circle.fill", name: "Jupiter", color: .brown, objects: [
                    SpaceObject(systemImage: "moon.fill", name: "Io", color: .yellow),
                    SpaceObject(systemImage: "moon.fill", name: "Europa", color: .gray),
                    SpaceObject(systemImage: "moon.fill", name: "Ganymede", color: .gray),
                    SpaceObject(systemImage: "moon.fill", name: "Callisto", color: .gray)
                ]),
                SpaceObject(systemImage: "circle.fill", name: "Saturn", color: .yellow, objects: [
                    SpaceObject(systemImage: "moon.fill", name: "Titan", color: .orange),
                    SpaceObject(systemImage: "moon.fill", name: "Enceladus", color: .gray)
                ]),
                SpaceObject(systemImage: "circle.fill", name: "Uranus", color: .cyan, objects: [
                    SpaceObject(systemImage: "moon.fill", name: "Titania", color: .gray),
                    SpaceObject(systemImage: "moon.fill", name: "Oberon", color: .gray)
                ]),
                SpaceObject(systemImage: "circle.fill", name: "Neptune", color: .blue, objects: [
                    SpaceObject(systemImage: "moon.fill", name: "Triton", color: .pink)
                ]),
                SpaceObject(systemImage: "circle.fill", name: "Pluto", color: .gray, objects: [
                    SpaceObject(systemImage: "moon.fill", name: "Charon", color: .gray)
                ])
            ]),
        SpaceObject(
            systemImage: "circle.dotted",
            name: "Proxima Centauri System",
            color: .primary,
            objects: [
                SpaceObject(systemImage: "sun.min.fill", name: "Proxima Centauri", color: .red),
                SpaceObject(systemImage: "circle.fill", name: "Proxima B", color: .green),
                SpaceObject(systemImage: "circle.fill", name: "Proxima D", color: .orange),
                SpaceObject(systemImage: "circle.fill", name: "Proxima C", color: .blue)
            ]
        )
    ]

    
    
    var body: some View {
        NavigationView {
            List(milkyWaySystems, children: \.objects) { object in
                HStack {
                    Image(systemName: object.systemImage)
                        .foregroundStyle(object.color)
                    Text(object.name)
                }
            }
            .overlay {
                VStack {
                    Spacer()
                    TabBarView()
                }
            }
        }
    }
    
}

#Preview {
    NestingListRowsView()
}
