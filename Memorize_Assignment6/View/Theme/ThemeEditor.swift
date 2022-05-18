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

    var cardNumberEditSection: some View {
        Section(header: Text("# of pair of cards")) {
            Stepper("\(theme.numberOfPairOfCards) pairs of cards", value: $theme.numberOfPairOfCards, in: 0...theme.emojis.count, step: 1)
        }
    }

    @State var emojisToAdd = ""
    var addEmojiSection: some View {
        // FIXME: add emojis
        Section(header: Text("add Emojis")) {
            TextField("emojis to add", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                    withAnimation {
                        theme.appendEmojis(emojis)
                    }
                }
        }
    }

    var removeEmojiSection: some View {
        Section(header: Text("Remove emojis")) {
            let emojisArray = Array(theme.emojis)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(emojisArray, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                theme.removeEmoji(emoji)
                            }
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
                    .onAppear(perform: {
                        themeColor = Color(rgbaColor: theme.color)
                    })
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
