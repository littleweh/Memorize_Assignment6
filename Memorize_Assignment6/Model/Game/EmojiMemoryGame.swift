//
//  EmojiMemoryGame.swift
//  Memorize_Assignment2
//
//  Created by 小威 on 2022/2/11.
//

import Foundation
import SwiftUI


class EmojiMemoryGame: ObservableObject {
    let theme: Theme

    @Published private var model: MemoryGame<String>

    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    var score: Int {
        model.score
    }

    var themeColor: Color {
        Color(rgbaColor: theme.color)
    }

    init(theme: Theme) {
        self.theme = theme

        let shuffledEmojis = theme.emojis.shuffled()
        model = MemoryGame<String>(numberOfPairOfCards: theme.numberOfPairOfCards, createCardContent: { index in shuffledEmojis[index] })
    }

    func createMemoryGame() -> MemoryGame<String> {
        let shuffledEmojis = theme.emojis.shuffled()
        return MemoryGame<String>(numberOfPairOfCards: theme.numberOfPairOfCards) { index in
            shuffledEmojis[index]
        }
    }

    // MARK: Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }

    func shuffle() {
        model.shuffle()
    }

    func restartGame() {
        model = createMemoryGame()
    }
}
