//
//  TabBarView.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 26.03.2025.
//

import SwiftUI

struct TabItemView<Content: View>: View {
    let systemImage: String
    let content: Content

    init(systemImage: String, @ViewBuilder content: @escaping () -> Content) {
        self.systemImage = systemImage
        self.content = content()
    }

    var body: some View {
        content
    }
}

private struct TabItem {
    let systemImage: String
    let content: AnyView
    
    init(
        systemImage: String,
        content: some View
    ) {
        self.systemImage = systemImage
        self.content = AnyView(content)
    }
}

// MARK: - Tab Bar View
struct TabBarView: View {
    @State private var selectedItem: Int = 0
    
    @State private var buttonFrames: [Int: CGRect] = [:]
    
    private let tabs: [TabItem?]
    
    private let width = UIScreen.main.bounds.width
    private let roundedRectangle = RoundedRectangle(cornerRadius: 45)
    
    private var circle: some View {
        Circle()
            .fill(.pink)
            .opacity(0.2)
            .scaleEffect(2)
            .frame(width: 30, height: 30)
    }
    
    init(
        @ViewBuilder content: () -> TupleView<(
            TabItemView<some View>,
            TabItemView<some View>
        )>
    ) {
        let tuple = content().value
        var items = [TabItem]()
        
        items.append(TabItem(systemImage: tuple.0.systemImage, content: tuple.0.content))
        items.append(TabItem(systemImage: tuple.1.systemImage, content: tuple.1.content))
        
        self.tabs = items
    }
    
    init(
        @ViewBuilder content: () -> TupleView<(
            TabItemView<some View>,
            TabItemView<some View>,
            TabItemView<some View>,
            TabItemView<some View>
        )>
    ) {
        let tuple = content().value
        
        var items = [TabItem]()
        
        items.append(TabItem(systemImage: tuple.0.systemImage, content: tuple.0.content))
        items.append(TabItem(systemImage: tuple.1.systemImage, content: tuple.1.content))
        items.append(TabItem(systemImage: tuple.2.systemImage, content: tuple.2.content))
        items.append(TabItem(systemImage: tuple.3.systemImage, content: tuple.3.content))
        
        self.tabs = items
    }
    
    var body: some View {
        ZStack {
            tabs[selectedItem]?.content
            VStack {
                Spacer()
                HStack {
                    
                    if tabs.count == 2 {
                        
                        build2Tabs()
                        
                    } else if tabs.count == 4 {
                        
                        build4Tabs()
                        
                    } else {
                        
                        fatalError("TabBarView initialized with wrong number of tabs.")
                        
                    }
                    
                }
                .frame(width: width * 0.8)
                .padding(.vertical, 15)
                .padding(.horizontal, 25)
                .background {
                    ZStack {
                        
                        // Blur
                        // https://stackoverflow.com/a/62350667
                        BackdropBlurView(radius: 10)
                            .padding(-20)
                            .clipShape(roundedRectangle)
                        
                        // Dynamic circle positioned behind selected tab
                        circle
                            .position(
                                x: buttonFrames[selectedItem]?.midX ?? 0,
                                y: buttonFrames[selectedItem]?.midY ?? 0
                            )
                            .animation(.bouncy(duration: 0.25), value: selectedItem)
                    }
                }
                .overlay {
                    // Stroke
                    roundedRectangle
                        .stroke(lineWidth: 1)
                        .fill(.tabBarBorder)
                }
                .coordinateSpace(name: "TabBarZStack")
                .onPreferenceChange(TabButtonFramePreferenceKey.self) {
                    buttonFrames = $0
                }
            }
        }
    }
    
    func build2Tabs() -> some View {
        HStack {
            Spacer()
            TabBarButton(
                systemImage: tabs[0]?.systemImage,
                buttonPosition: 0,
                selectedItem: $selectedItem
            )
            Spacer()
            ButtonDesign(width: 55, height: 55, cornerRadius: 12)
            Spacer()
            TabBarButton(
                systemImage: tabs[1]?.systemImage,
                buttonPosition: 1,
                selectedItem: $selectedItem
            )
            Spacer()
        }
    }
    
    func build4Tabs() -> some View {
        HStack {
            // Tab buttons
            TabBarButton(
                systemImage: tabs[0]?.systemImage,
                buttonPosition: 0,
                selectedItem: $selectedItem
            )
            Spacer()
            TabBarButton(
                systemImage: tabs[1]?.systemImage,
                buttonPosition: 1,
                selectedItem: $selectedItem
            )
            Spacer()
            ButtonDesign(width: 55, height: 55, cornerRadius: 12)
            Spacer()
            TabBarButton(
                systemImage: tabs[2]?.systemImage,
                buttonPosition: 2,
                selectedItem: $selectedItem
            )
            Spacer()
            TabBarButton(
                systemImage: tabs[3]?.systemImage,
                buttonPosition: 3,
                selectedItem: $selectedItem
            )
        }
    }
}

// MARK: - Preference Key for Tracking Button Frames
struct TabButtonFramePreferenceKey: PreferenceKey {
    static var defaultValue: [Int: CGRect] = [:]
    
    static func reduce(value: inout [Int: CGRect], nextValue: () -> [Int: CGRect]) {
        value.merge(nextValue()) { (_, new) in new }
    }
}

// MARK: - Preview
#Preview {
    TabBarView {
        TabItemView(systemImage: "house") {
            Image(systemName: "house")
                .resizable()
                .scaledToFit()
        }
        TabItemView(systemImage: "checklist") {
            Image(systemName: "checklist")
                .resizable()
                .scaledToFit()
        }
        TabItemView(systemImage: "sparkles") {
            Text("Sparkles")
                .font(.system(size: 36))
        }
        TabItemView(systemImage: "gearshape") {
            Text("Gearshape")
                .font(.system(size: 36))
        }
    }
}
