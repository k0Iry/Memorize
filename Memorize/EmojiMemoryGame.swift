//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Iry Tu on 2021-01-20.
//

import Foundation

class EmojiMemoryGame {
    private var game: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🕷️", "☠️", "🧚‍♀️",
                      "👽", "🌕", "🌑", "🍬", "🧟‍♀️"].shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        return game.cards.shuffled()
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
}
