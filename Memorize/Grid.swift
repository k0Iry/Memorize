//
//  Grid.swift
//  Memorize
//
//  Created by Iry Tu on 2021-03-14.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item : Identifiable, ItemView : View {
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    
    init(items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridLayout = GridLayout(itemCount: items.count, nearAspectRatio: 2/3, in: geometry.size)
            ForEach(items) { item in
                viewForItem(item)
                    .aspectRatio(2/3, contentMode: .fit)    // scale to fit the frame below
                    .frame(width: gridLayout.itemSize.width, height: gridLayout.itemSize.height)
                    .position(gridLayout.location(ofItemAt: items.firstIndex(matching: item)!))
            }
        }
    }
}
