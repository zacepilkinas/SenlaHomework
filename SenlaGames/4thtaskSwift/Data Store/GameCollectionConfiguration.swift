//
//  GameCollectionConfiguration.swift
//  4thtaskSwift
//
//  Created by Anastasia on 15.04.2022.
//

import UIKit


struct GameContentConfiguration: UIContentConfiguration {
    let computerChoice: Selection
    let urChoice: Selection
    let result: String?
    
    func makeContentView() -> UIView & UIContentView {
        GameContentView(with: self)
    }
    
    func updated(for state: UIConfigurationState) -> GameContentConfiguration {
        self
    }
}


final class GameContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration
    
    private let computerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let urChoiceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    init(with contentConfiguration: GameContentConfiguration) {
        configuration = contentConfiguration
        super.init(frame: .zero)
        layer.borderWidth = 1.5
        backgroundColor = .systemPink
        addSubview(computerLabel)
        addSubview(urChoiceLabel)
        addSubview(resultLabel)
        makeConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let content = configuration as? GameContentConfiguration else {
            return
        }
        computerLabel.text = "Computer choice: \(content.computerChoice)"
        urChoiceLabel.text = "Player choice: \(content.urChoice)"
        resultLabel.text = "Result: \(content.result ?? "")"
    }
    
    private func makeConstraints() {
        computerLabel.translatesAutoresizingMaskIntoConstraints = false
        urChoiceLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            computerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            computerLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 17),
            
            urChoiceLabel.topAnchor.constraint(equalTo: computerLabel.bottomAnchor, constant: 17),
            urChoiceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            
            resultLabel.topAnchor.constraint(equalTo: urChoiceLabel.bottomAnchor, constant: 17),
            resultLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        ])
    }
}
