//
//  GameStatisticsContentConfiguration.swift
//  4thtaskSwift
//
//  Created by Anastasia on 25.04.2022.
//

import UIKit


struct GameStatisticsContentConfiguration: UIContentConfiguration {
    
    var gameStatistics: Int = 0
    
    func makeContentView() -> UIView & UIContentView {
        GameStatisticsContentView(with: self)
    }
    
    func updated(for state: UIConfigurationState) -> GameStatisticsContentConfiguration {
        self
    }
}

class GameStatisticsContentView: UIView, UIContentView {
    
    var configuration: UIContentConfiguration
    
    private var gameStatisticsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    init(with contentConfiguration: GameStatisticsContentConfiguration) {
        configuration = contentConfiguration
        super.init(frame: .zero)
        layer.borderWidth = 2.0
        backgroundColor = .black
        addSubview(gameStatisticsLabel)
        makeConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let content = configuration as? GameStatisticsContentConfiguration else {
            return
        }
        gameStatisticsLabel.text = "Game statistics: \(content.gameStatistics)"
    }
    
    private func makeConstraints() {
        gameStatisticsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gameStatisticsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            gameStatisticsLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
