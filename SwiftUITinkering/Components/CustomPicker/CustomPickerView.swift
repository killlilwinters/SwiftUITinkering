//
//  CustomPickerView.swift
//  SwiftUITinkering
//
//  Created by Maks Winters on 22.04.2025.
//

import SwiftUI

struct IdentifiableViewContainer<Content: View>: Identifiable {
    let id: Int
    let content: Content
}

struct CustomPickerView<Label, SelectionValue, each Content>: View

where Label: View, SelectionValue: Hashable, repeat each Content: View {
    
    let label: Label
    @Binding var selectionValue: SelectionValue
    let content: TupleView<(repeat each Content)>

    init(
        label: Label,
        selectionValue: Binding<SelectionValue>,
        @ViewBuilder content: @escaping () -> TupleView<(repeat each Content)>
    ) {
        self.label = label
        self._selectionValue = selectionValue
        // here the builder automatically returns a TupleView<…>
        self.content = content()
    }

    var body: some View {
        let views = getViews()
        ForEach(views, id: \.id) { idView in
            idView.content
        }
    }
    
    func getViews() -> Array<IdentifiableViewContainer<AnyView>> {
        var views: Array<IdentifiableViewContainer<AnyView>> = .init()
        
        var count = 0
        for viewElement in repeat each content.value {
            let idView = IdentifiableViewContainer(id: count, content: AnyView(viewElement))
            views.append(idView)
            count += 1
        }
        return views
    }
    
}

#Preview {
    CustomPickerView(label: Text("Choose:"), selectionValue: .constant(1)) {
        Text("One").tag(1)
        Text("Two").tag(2)
        Text("Three").tag(3)
    }
}

