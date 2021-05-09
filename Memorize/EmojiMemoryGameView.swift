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
            Button("New Game") {
                withAnimation(.easeInOut) {
                    emojiGame.newEmojiGame()
                }
            }
            .buttonStyle(BorderlessButtonStyle())
            .padding(5)
        }

        Grid(items: emojiGame.cards) { card in
            CardView(card: card).onTapGesture {
                withAnimation(.linear(duration: 0.75)) {
                    emojiGame.choose(card)
                }
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
    
    @State private var animatedBonusRemaining: Double = 0

    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(startAngle: Angle.radians(-Double.pi / 2), endAngle: Angle.degrees(-animatedBonusRemaining * 360 - 90), clockWise: true)
                                .onAppear {
                                    animatedBonusRemaining = card.bonusRemaining
                                    withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                        animatedBonusRemaining = 0
                                    }
                                }
                        } else {
                            Pie(startAngle: Angle.radians(-Double.pi / 2), endAngle: Angle.degrees(-card.bonusRemaining * 360 - 90), clockWise: true)
                        }
                    }
                    .padding(5)
                    .opacity(0.4)
                    
                    Text(card.content)
                        .font(Font.system(size: bodySize(for: geometry.size)))
                        .rotationEffect(Angle.radians(card.isMatched ? Double.pi * 2 : 0))
                        // animation only applied to changes, which means the view should have been on the screen but got changes, if the view
                        // e.g. got re-drawn, it won't trigger the animation
                        .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(AnyTransition.scale)
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
