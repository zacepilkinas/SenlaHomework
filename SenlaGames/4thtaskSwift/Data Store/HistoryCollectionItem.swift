//
//  HistoryCollectionItem.swift
//  4thtaskSwift
//
//  Created by Anastasia on 15.04.2022.
//

import UIKit


struct HistoryCollectionItem: Hashable {
    let uuid = UUID()
    
    enum ItemType {
        case cubeStatistics(configuration: CubeStatisticsContentConfiguration)
        case gameStatistics(configuration: GameStatisticsContentConfiguration)
        case cube(configuration: CubeContnetConfiguration)
        case game(configuration: GameContentConfiguration)
    }
    
    let content: ItemType
    
    init(content: ItemType) {
        self.content = content
    }
    
    static func == (lhs: HistoryCollectionItem, rhs: HistoryCollectionItem) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
