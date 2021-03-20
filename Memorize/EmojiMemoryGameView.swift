//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Iry Tu on 2021-01-18.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var emojiGame = EmojiMemoryGame()
    
    var body: some View {
        Grid(items: emojiGame.cards) { card in
            CardView(card: card).onTapGesture {
                emojiGame.choose(card)
            }
            .aspectRatio(2/3, contentMode: .fit)
            .padding(5)
        }
        .padding()
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                    Text(card.content)
                } else {
                    if !card.isMatched {
                        RoundedRectangle(cornerRadius: cornerRadius).fill()
                    }
                }
            }
            .font(Font.system(size: bodySize(for: geometry.size)))
        }
    }
    
    func bodySize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.75
    }
    
    // MARK: - Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
}
