//
//  GameView.swift
//  Memorize_Assignment1
//
//  Created by 小威 on 2022/2/4.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        let themeColor = viewModel.themeColor
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                        ForEach(viewModel.cards) { card in
                            CardView(card: card, color: themeColor)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    viewModel.choose(card)
                                }
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()

                Text("Score: \(viewModel.score)")
                    .font(.body)
                    .padding()
            }
        }
        .navigationBarTitle(viewModel.theme.name, displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.restartGame()
                } label: {
                    Text("New Game")
                }
            }
        }

    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let theme = EmojiGameTheme.vehicle.theme
        GameView(viewModel: EmojiMemoryGame(theme: theme))
.previewInterfaceOrientation(.portrait)
    }
}
