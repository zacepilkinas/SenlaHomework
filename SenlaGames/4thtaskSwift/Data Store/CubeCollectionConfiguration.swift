//
//  CubeCollectionConfiguration.swift
//  4thtaskSwift
//
//  Created by Anastasia on 15.04.2022.
//

import UIKit


struct CubeContnetConfiguration: UIContentConfiguration {
    let result: String?
    
    func makeContentView() -> UIView & UIContentView {
        CubeContentView(with: self)
    }
    
    func updated(for state: UIConfigurationState) -> CubeContnetConfiguration {
        self
    }
}


final class CubeContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    init(with contentConfiguration: CubeContnetConfiguration) {
        configuration = contentConfiguration
        super.init(frame: .zero)
        layer.borderWidth = 1.0
        backgroundColor = .black
        addSubview(label)
        makeConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let content = configuration as? CubeContnetConfiguration else {
            return
        }
        label.text = "Rolling dice result: \(content.result ?? "")"
    }
    
    private func makeConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           
            label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 17),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        ])
    }
}
