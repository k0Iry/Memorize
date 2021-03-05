//
//  ContentView.swift
//  Memorize
//
//  Created by Iry Tu on 2021-01-18.
//

import SwiftUI

struct ContentView: View {
    var emojiGame = EmojiMemoryGame()
    
    var body: some View {
        HStack {
            ForEach(emojiGame.cards) { card in
                CardView(card: card).onTapGesture {
                    emojiGame.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(.orange)
        .font(emojiGame.cards.count != 5 ? Font.largeTitle : Font.footnote)
        .aspectRatio(2/3, contentMode: .fit)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}
