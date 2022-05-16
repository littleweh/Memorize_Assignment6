//
//  ThemeEditor.swift
//  Memorize_Assignment6
//
//  Created by 小威 on 2022/5/15.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme

    // a Binding to a PresentationMode
    // which lets us dismiss() ourselves if we are isPresented
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                nameEditSection
                addEmojiSection
                removeEmojiSection
                cardNumberEditSection
                colorPickSection
            }
            .navigationTitle("Edit \(theme.name)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if presentationMode.wrappedValue.isPresented,
                       UIDevice.current.userInterfaceIdiom != .pad {
                        Button("Done") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }

    var nameEditSection: some View {
        Section(header: Text("name")) {
            TextField("name", text: $theme.name)
        }
    }

    @State var cardPairNumberToUpdate = ""
    var cardNumberEditSection: some View {
        Section(header: Text("# of pair of cards")) {
            TextField("number of pair of cards", text: $cardPairNumberToUpdate)
                .keyboardType(.numberPad)
                .onChange(of: cardPairNumberToUpdate) { pairNumber in
                    updateCardPairNumber(Int(pairNumber))
                }
        }
    }

    private func updateCardPairNumber(_ number: Int?) {
        guard let number = number else { return }
        let _ = theme.updateNumberOfPairOfCards(number)
    }

    @State var emojisToAdd = ""
    var addEmojiSection: some View {
        // FIXME: add emojis
        Section(header: Text("add Emojis")) {
            TextField("emojis to add", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                    addEmojis(emojis)
                }
        }
    }

    private func addEmojis(_ emojis: String) {
        withAnimation {
            theme.appendEmojis(emojis)
        }
    }

    var removeEmojiSection: some View {
        // FIXME: remove emojis
        Section(header: Text("Remove emojis")) {
            let emojisArray = Array(theme.emojis)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(emojisArray, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            theme.removeEmoji(emoji)
                        }
                }
            }
        }
    }

    @State private var themeColor = Color.white

    var colorPickSection: some View {
        Section(header: Text("color")) {
            VStack {
                ColorPicker("choose a color", selection: $themeColor, supportsOpacity: true)
                    .onChange(of: themeColor) { color in
                        theme.color = RGBAColor(color: color)
                    }
            }
        }

    }
}

struct ThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        let theme = EmojiGameTheme.vehicle.theme
        ThemeEditor(theme: .constant(theme))
    }
}
