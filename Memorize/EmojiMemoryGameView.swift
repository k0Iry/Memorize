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
        HStack() {
            Text(emojiGame.themeName())
                .italic()
            Button("New Game") { emojiGame.newEmojiGame() }
                .buttonStyle(BorderlessButtonStyle())
                .padding(5)
        }

        Grid(items: emojiGame.cards) { card in
            CardView(card: card).onTapGesture {
                emojiGame.choose(card)
            }
            .padding(5)
        }
        .padding()
        .foregroundColor(emojiGame.themeColor())

        HStack {
            Text("Score: " + String(emojiGame.gameScore()))
                .bold()
                .font(.largeTitle)
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Pie(startAngle: Angle.radians(-Double.pi / 2), endAngle: Angle.degrees(20), clockWise: true)
                        .padding(5)
                        .opacity(0.4)
                    Text(card.content)
                        .font(Font.system(size: bodySize(for: geometry.size)))
                }
                .cardify(isFaceUp: card.isFaceUp)
            }
        }
    }
    
    private func bodySize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards[0])
        return EmojiMemoryGameView(emojiGame: game)
    }
}
