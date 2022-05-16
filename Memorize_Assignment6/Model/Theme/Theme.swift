//
//  Theme.swift
//  Memorize_Assignment1
//
//  Created by 小威 on 2022/2/4.
//

import Foundation

struct Theme: Identifiable, Codable, Hashable {
    var id: UUID
    var name: String
    var emojis: Set<String>
    var numberOfPairOfCards: Int
    var color: RGBAColor

    init(name: String, emoji: String?, numberOfPairOfCards: Int = 4, color: RGBAColor) {
        self.id = UUID()
        self.name = name
        self.color = color
        self.emojis = emoji?.setOfEmojiElement ?? []
        self.numberOfPairOfCards = numberOfPairOfCards > emojis.count ? emojis.count : numberOfPairOfCards
    }

    mutating func appendEmojis(_ emojis: String?) {
        let newEmojis = emojis?.setOfEmojiElement ?? []
        self.emojis = self.emojis.union(newEmojis)
    }

    mutating func updateNumberOfPairOfCards(_ number: Int) -> Bool {
        guard number > 2, number < emojis.count else { return false }
        self.numberOfPairOfCards = number
        return true
    }

    mutating func removeEmoji(_ emoji: String) {
        self.emojis.remove(emoji)
    }
}

extension Theme {
    var emojiString: String? {
        guard !emojis.isEmpty else { return nil }
        return emojis.joined(separator: "")
    }
}
