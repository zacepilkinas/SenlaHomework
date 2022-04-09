//
//  Languages.swift
//  4thtaskSwift
//
//  Created by Anastasia on 04.04.2022.
//

import Foundation

protocol Translation {
    var tie: String {get set}
    var win: String {get set}
    var computer: String {get set}
    var gameTitle: String {get set}
    var settingsTitle: String {get set}
    var cubeLabel: String {get set}
}


enum Languages: String, CaseIterable {
    case english = "Eng"
    case russian = "Rus"
}


struct EnglishLanguage: Translation {
    var tie: String = "Tie"
    var win: String = "U win"
    var computer: String = "Computer wins"
    var gameTitle: String = "Game"
    var settingsTitle: String = "Settings"
    var cubeLabel: String = "Start"
}


struct RussianLanguage: Translation {
    var tie: String = "Ничья"
    var win: String = "Ты выиграл"
    var computer: String = "Компьютер выиграл"
    var gameTitle: String = "Игра"
    var settingsTitle: String = "Настройки"
    var cubeLabel: String = "Старт"
}


final class LanguageLocalization {
    
    static let shared = LanguageLocalization()
    
    private init() {}
    
    var language: Languages = .english {
        didSet {
            switch language {
            case .english:
                self.dictionary = EnglishLanguage()
            case .russian:
                self.dictionary = RussianLanguage()
            }
        }
    }
    var dictionary: Translation = EnglishLanguage()
}
