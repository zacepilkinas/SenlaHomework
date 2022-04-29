//
//  GameMode.swift
//  4thtaskSwift
//
//  Created by Anastasia on 05.04.2022.
//

import Foundation


enum GameMode: String, CaseIterable {
    case withTie = "on"
    case withOutTie = "off"
}


final class GameModeLocalization {
    
    static let shared = GameModeLocalization()
    
    private init() {}
    
    var gameMode: GameMode = .withTie {
        didSet {
            switch gameMode {
            case .withTie:
                self.gameMode = .withTie
            case .withOutTie:
                self.gameMode = .withOutTie
            }
        }
    }
    var mode: GameMode = .withTie
}
