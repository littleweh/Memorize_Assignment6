//
//  ThemeChooserView.swift
//  Memorize_Assignment6
//
//  Created by 小威 on 2022/5/14.
//

import SwiftUI

struct ThemeChooser: View {
    @EnvironmentObject var store: ThemeStore
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var editMode: EditMode = .inactive

    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    // tapping on this row in the List will navigate to a Game with this theme
                    NavigationLink(destination: GameView(viewModel: EmojiMemoryGame(theme: theme))) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(theme.name)
                                    .font(.title)
                                Color(rgbaColor: theme.color)
                                    .frame(width: 20, height: 20, alignment: .leading)
                            }

                            Text(themeInfo(theme))
                                .font(.body)
                        }
                        .gesture(editMode == .active ? tap(theme: theme) : nil)
                    }
                }
                .onDelete { indexSet in
                    store.themes.remove(atOffsets: indexSet)
                }
                .onMove { indexSet, newOffset in
                    store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                }
            }
            .navigationTitle("Memorize")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("+") {
                        store.insertTheme(named: "New", numberOfPairOfCards: 2, color: RGBAColor(color: colorScheme == .light ? Color.black : Color.white))
                        themeToEdit = store.theme(at: 0)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .environment(\.editMode, $editMode)
        }
        .popover(item: $themeToEdit) { theme in
            // FIXME: after update any column in ThemeEditor, the pop over become nil
//            if let index = store.themes.firstIndex(of: theme) {
//                ThemeEditor(theme: $store.themes[index])
//            }
            ThemeEditor(theme:$store.themes[theme])
        }

    }

    @State var themeToEdit: Theme?
    func tap(theme: Theme) -> some Gesture {
        TapGesture().onEnded {
            themeToEdit = theme
        }
    }

    private func themeInfo(_ theme: Theme) -> String {
        let text = "\(theme.numberOfPairOfCards) pairs of "
        let emojiString = emojis(theme.emojis, shouldTruncate: theme.numberOfPairOfCards < theme.emojis.count)
        return text + emojiString
    }

    private func emojis(_ emojis: Set<String>, shouldTruncate: Bool) -> String {
        var emojiString = ""
        let truncateNumber = shouldTruncate ? 6 : emojis.count

        for (index, emoji) in emojis.shuffled().enumerated() {
            if index > truncateNumber { break }
            emojiString += emoji
        }
        return emojiString
    }
}

struct ThemeChooserView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooser().environmentObject(ThemeStore(named: "previewStore"))
    }
}
