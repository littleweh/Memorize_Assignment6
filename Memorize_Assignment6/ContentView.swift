//
//  ContentView.swift
//  Memorize_Assignment6
//
//  Created by 小威 on 2022/5/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let themeStore = ThemeStore(named: "memorizeThemeStore")
        ThemeChooserView().environmentObject(themeStore)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
