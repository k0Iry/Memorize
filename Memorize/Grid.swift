//
//  Grid.swift
//  Memorize
//
//  Created by Iry Tu on 2021-03-14.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item : Identifiable, ItemView : View {
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    
    init(items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridLayout = GridLayout(itemCount: items.count, in: geometry.size)
            ForEach(items) { item in
                viewForItem(item)
                    .frame(width: gridLayout.itemSize.width, height: gridLayout.itemSize.height)
                    .position(gridLayout.location(ofItemAt: items.firstIndex(matching: item)!))
            }
        }
    }
}
