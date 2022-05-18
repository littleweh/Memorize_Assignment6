//
//  EmojiGameTheme.swift
//  Memorize_Assignment6
//
//  Created by 小威 on 2022/5/14.
//

import Foundation

enum EmojiGameTheme: Int, CaseIterable {
    case vehicle = 0
    case food
    case weather
    case face
    case occupation
    case flag

    var theme: Theme {
        switch self {
        case .vehicle:
            return Theme(
                name: "Vehicle",
                emoji:"🚗🚓🚑🚒🛻🚚🚲🛵🏍🚝✈️🚀🛸🚁🚢⛴🚤🚖🛺🦽",
                numberOfPairOfCards: 5,
                color: RGBAColor(red: 0, green: 0, blue: 102, alpha: 1)
            )
        case .food:
            return Theme(
                name: "Foods",
                emoji:"🍌🥝🍎🥬🥦🌽🧄🧅🥐🧀🥚🍖🍕🍤🍙",
                numberOfPairOfCards: 20,
                color: RGBAColor(red: 0, green: 204, blue: 102, alpha: 1)
            )
        case .face:
            return Theme(
                name: "Faces",
                emoji: "👶🏼👨🏾👩🏾‍🦱👩🏻‍🦰🧑🏻‍🦰👩🏽‍🦳🧑‍🦳👵🏼👳🏽👳🏻‍♂️🧔🏿👱🏿‍♀️",
                numberOfPairOfCards: 0,
                color: RGBAColor(red: 255, green: 255, blue: 0, alpha: 1)
            )
        case .flag:
            return Theme(
                name: "Flags",
                emoji: "🏳️‍🌈🏁🚩🇨🇫🇯🇵🇹🇼🇸🇿🇳🇪🇮🇸🇭🇺🇹🇰🇹🇱🇩🇯🇫🇷🇫🇮🇸🇸🇰🇷🇺🇸🏴󠁧󠁢󠁳󠁣󠁴󠁿🇭🇰",
                numberOfPairOfCards: 10,
                color: RGBAColor(red: 20, green: 20, blue: 20, alpha: 1)
            )
        case .occupation:
            return Theme(
                name: "Job",
                emoji:"👮🏽‍♀️👷🏾‍♀️💂🏻👩🏻‍⚕️🕵🏻‍♂️👨🏻‍🌾👩🏿‍🌾🧑🏽‍🎓👨🏻‍🍳👨🏽‍🎤🧑🏼‍🏫👨🏻‍🏭🧑🏻‍💼👩🏽‍🔬👩🏻‍🎨",
                numberOfPairOfCards: 7,
                color: RGBAColor(red: 0, green: 0, blue: 0, alpha: 1)
            )
        case .weather:
            return Theme(
                name: "Weather",
                emoji: "🌛🌜🌞🌙☀️🌤⛅️🌥☁️🌦🌧☃️❄️🌨🌩⛈☔️☂️💨🌈",
                numberOfPairOfCards: 12,
                color: RGBAColor(red: 122, green: 51, blue: 0, alpha: 1)
            )
        }
    }

}
