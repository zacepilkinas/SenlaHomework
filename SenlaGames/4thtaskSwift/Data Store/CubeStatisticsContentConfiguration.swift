//
//  BestSetCollectionConfiguration.swift
//  4thtaskSwift
//
//  Created by Anastasia on 15.04.2022.
//

import UIKit


struct CubeStatisticsContentConfiguration: UIContentConfiguration {
    var one: Int
    var two: Int
    var three: Int
    var four: Int
    var five: Int
    var six: Int
    
    func makeContentView() -> UIView & UIContentView {
        CubeStatisticsContentView(with: self)
    }
    
    func updated(for state: UIConfigurationState) -> CubeStatisticsContentConfiguration {
        self
    }
}


final class CubeStatisticsContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration
    
    private var firstLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let thirdLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let forthLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let fifthLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let sixthLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    init(with contentConfiguration: CubeStatisticsContentConfiguration) {
        configuration = contentConfiguration
        super.init(frame: .zero)
        layer.borderWidth = 2.0
        backgroundColor = .black
        addSubview(firstLabel)
        addSubview(secondLabel)
        addSubview(thirdLabel)
        addSubview(forthLabel)
        addSubview(fifthLabel)
        addSubview(sixthLabel)
        makeConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let content = configuration as? CubeStatisticsContentConfiguration else {
            return
        }
        firstLabel.text = "One: \(content.one)"
        secondLabel.text = "Two: \(content.two)"
        thirdLabel.text = "Three: \(content.three)"
        forthLabel.text = "Four: \(content.four)"
        fifthLabel.text = "Five: \(content.five)"
        sixthLabel.text = "Six: \(content.six)"
    }
    
    private func makeConstraints() {
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        thirdLabel.translatesAutoresizingMaskIntoConstraints = false
        forthLabel.translatesAutoresizingMaskIntoConstraints = false
        fifthLabel.translatesAutoresizingMaskIntoConstraints = false
        sixthLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          
            firstLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            firstLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            
            secondLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            secondLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            thirdLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            thirdLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            forthLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 230),
            forthLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            
            fifthLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 230),
            fifthLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            sixthLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 230),
            sixthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
}
