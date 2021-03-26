//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Iry Tu on 2021-01-20.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    @Published private var game: MemoryGame<String> = createMemoryGame()
    
    private var theme: Theme?
    
    private static let themes = [
        Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷️", "☠️", "🧚‍♀️", "👽", "🌕", "🌑", "🍬", "🧟‍♀️"], color: .orange),
        Theme(name: "Faces", emojis: ["😄", "😫", "🤢", "😡", "😂", "😢", "😙"], numberOfCards: 7, color: .pink),
        Theme(name: "Animals", emojis: ["🐔", "🦆", "🐂", "🐐", "🐬", "🐘", "🐯", "🦁️", "🐑"], color: .green),
        Theme(name: "Vehicles", emojis: ["🚗", "🚄", "✈️", "🚢", "🚇", "🚐", "🛺", "🚜", "🚁"], color: .blue)
    ]
    
    static func createMemoryGame() -> MemoryGame<String> {
        let theme = EmojiMemoryGame.themes[Int.random(in: 0..<EmojiMemoryGame.themes.count)]
        return createMemoryGame(with: theme)
    }
    
    static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: (theme.numberOfCards ?? Int.random(in: 1...emojis.count))) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    func newEmojiGame() {
        theme = EmojiMemoryGame.themes[Int.random(in: 0..<EmojiMemoryGame.themes.count)]
        game = EmojiMemoryGame.createMemoryGame(with: theme!)
    }
    
    // MARK: - Access to the Model
    
    func themeColor() -> Color {
        if let chosenTheme = theme {
            return chosenTheme.color
        }
        return .orange
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        game.cards
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        game.choose(card)
    }
    
    struct Theme {
        var name: String
        var emojis: Array<String>
        var numberOfCards: Int?
        var color: Color
    }
}
