//
//  DataStore.swift
//  4thtaskSwift
//
//  Created by Anastasia on 15.04.2022.
//

import UIKit


public struct DataStore {
    var cubeStatisticsData = CubeStatisticsContentConfiguration(one: 0, two: 0, three: 0, four: 0, five: 0, six: 0)
    
    var gameStatisticsData = GameStatisticsContentConfiguration()
    
    var gameData: [GameContentConfiguration] = []
    
    var cubeData: [CubeContnetConfiguration] = []
}
