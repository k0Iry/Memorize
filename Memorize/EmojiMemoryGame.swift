//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Iry Tu on 2021-01-20.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    @Published private var game: (theme: Theme, emojiMemoryGame: MemoryGame<String>) = createMemoryGame()
    
    private static let themes = [
        Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷️", "☠️", "🧚‍♀️", "👽", "🌕", "🌑", "🍬", "🧟‍♀️"], color: .orange),
        Theme(name: "Faces", emojis: ["😄", "😫", "🤢", "😡", "😂", "😢", "😙"], numberOfCards: 7, color: .pink),
        Theme(name: "Animals", emojis: ["🐔", "🦆", "🐂", "🐐", "🐬", "🐘", "🐯", "🦁️", "🐑"], color: .green),
        Theme(name: "Vehicles", emojis: ["🚗", "🚄", "✈️", "🚢", "🚇", "🚐", "🛺", "🚜", "🚁"], color: .gray),
        Theme(name: "Food", emojis: ["🍚", "🍜", "🥬", "🥒", "🥓", "🍳", "🥛", "🍹", "🍔", "🥪"], color: .yellow),
        Theme(name: "Weather", emojis: ["⚡️", "🧊", "☁️", "❄️", "🌧️", "☀️", "🌫️"], color: .blue)
    ]
    
    private static func createMemoryGame() -> (theme: Theme, emojiMemoryGame: MemoryGame<String>) {
        let theme = EmojiMemoryGame.themes[Int.random(in: 0..<EmojiMemoryGame.themes.count)]
        let emojis = theme.emojis.shuffled()
        return (theme: theme,
                emojiMemoryGame: MemoryGame<String>(numberOfPairsOfCards: (theme.numberOfCards ?? Int.random(in: 1...emojis.count))) { pairIndex in
            emojis[pairIndex]
        })
    }
    
    // MARK: - Access to the Model
    
    func gameScore() -> Int {
        game.emojiMemoryGame.score
    }
    
    func themeName() -> String {
        game.theme.name
    }
    
    func themeColor() -> Color {
        game.theme.color
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        game.emojiMemoryGame.cards
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        game.emojiMemoryGame.choose(card)
    }
    
    func newEmojiGame() {
        game = EmojiMemoryGame.createMemoryGame()
    }
    
    struct Theme {
        let name: String
        let emojis: Array<String>
        var numberOfCards: Int?
        let color: Color
    }
}
