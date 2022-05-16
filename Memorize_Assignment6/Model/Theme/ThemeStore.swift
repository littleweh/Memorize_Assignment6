//
//  ThemeStore.swift
//  Memorize_Assignment6
//
//  Created by 小威 on 2022/5/15.
//

import SwiftUI

class ThemeStore: ObservableObject {
    let name: String
    @Published var themes: [Theme] {
        didSet {
            storeInUserDefaults()
        }
    }

    // MARK: persistence- userDefault

    private var userDefaultKey: String {
        "ThemeStore:" + name
    }

    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.object(forKey: userDefaultKey) as? Data,
           let decodeThemes = try? JSONDecoder().decode([Theme].self, from:jsonData) {
            themes = decodeThemes
        }
    }

    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultKey)
    }

    init(named name: String) {
        self.name = name
        self.themes = []
        restoreFromUserDefaults()

        if self.themes.isEmpty {
            self.themes = EmojiGameTheme.allCases.compactMap{ $0.theme }
        }
    }

    // MARK: Intent

    func theme(at index: Int) -> Theme? {
        guard themes.indices.contains(index) else { return nil }
        return themes[index]
    }

    @discardableResult
    func removeTheme(from index: Int) -> Int {
        if themes.count > 1, themes.indices.contains(index) {
            themes.remove(at: index)
        }
        return index % themes.count
    }

    func insertTheme(named name: String, emoji: String? = nil, numberOfPairOfCards: Int, color: RGBAColor, at index: Int = 0) {
        let theme = Theme(name: name, emoji: emoji, numberOfPairOfCards: numberOfPairOfCards, color: color)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
    }
}
