//
//  CardView.swift
//  Memorize_Assignment1
//
//  Created by 小威 on 2022/2/4.
//

import SwiftUI

struct CardView: View {
    var card: MemoryGame<String>.Card
    var color: Color

    var shape = RoundedRectangle(cornerRadius: 20)

    var body: some View {
        ZStack {
            if card.isFaceUp {
                shape.strokeBorder(lineWidth: 3)
                    .foregroundColor(color)
                Text(card.content).font(.largeTitle)
                    .font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            }
            else {
                shape.fill().foregroundColor(color)
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = MemoryGame<String>.Card(id: 0, content: "🌝")
        CardView(card:card, color: .yellow)
    }
}
