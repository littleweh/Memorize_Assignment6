//
//  MemoryGame.swift
//  Memorize_Assignment2
//
//  Created by 小威 on 2022/2/11.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]

    private var indexOfTheOneAndOnlyFaceUpCard: Int?

    private(set) var score: Int = 0

    mutating func choose(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
              !cards[chosenIndex].isFaceUp,
              !cards[chosenIndex].isMatched else {
                  return
              }

        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            if card.content == cards[potentialMatchIndex].content {
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
            }

            score += (score(for: cards[chosenIndex]) + score(for: cards[potentialMatchIndex]))
            recordCardsSeen(with: [chosenIndex, potentialMatchIndex])

            indexOfTheOneAndOnlyFaceUpCard = nil
        } else {
            for index in cards.indices {
                cards[index].isFaceUp = false
            }
            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
        cards[chosenIndex].isFaceUp = true
    }

    mutating func shuffle() {
        cards.shuffled()
    }

    private func score(for card: Card) -> Int {
        if card.isMatched {
            return 1
        } else if card.isFlippedBefore {
            return -1
        } else {
            return 0
        }
    }

    private mutating func recordCardsSeen(with indices: [Int]) {
        for index in indices {
            toggleIsCardSeenIfNeeded(with: index)
        }
    }

    private mutating func toggleIsCardSeenIfNeeded(with index: Int) {
        guard cards.indices.contains(index), !cards[index].isFlippedBefore else { return }
        cards[index].isFlippedBefore = true
    }

    init(numberOfPairOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []

        for pairIndex in 0..<numberOfPairOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(id: 2 * pairIndex, content: content))
            cards.append(Card(id: 2 * pairIndex + 1, content: content))
        }

        cards.shuffle()
    }


    struct Card: Identifiable {
        let id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isFlippedBefore: Bool = false
        var seen: Bool = false
        var content: CardContent
    }
}
