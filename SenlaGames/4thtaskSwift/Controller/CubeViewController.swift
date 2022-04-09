//
//  CalculatorViewController.swift
//  4thtaskSwift
//
//  Created by Anastasia on 29.03.2022.
//

import UIKit

class CubeViewController: UIViewController {
    
    private var translater: Translation = EnglishLanguage()

    lazy var cubeButton: UIButton = {
        let button = UIButton()
        button.setTitle("🎲", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 120)
        button.addAction(UIAction() { [weak self] _ in
            self?.rollDice()
        }, for: .touchUpInside)
        return button
    }()
    
    lazy var cubeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.text = translater.cubeLabel
        label.textAlignment = .center
        return label
    }()
    
    lazy var cubeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        setup()
        makeConstraints()
        rollDice()
    }
}


extension CubeViewController {
    
    func setup() {
        view.backgroundColor = .white
        cubeView.backgroundColor = .systemPink
    }
    
    func addSubView() {
        view.addSubview(cubeView)
        view.addSubview(cubeButton)
        view.addSubview(cubeLabel)
    }
    
    func makeConstraints() {
        cubeButton.translatesAutoresizingMaskIntoConstraints = false
        cubeLabel.translatesAutoresizingMaskIntoConstraints = false
        cubeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
        cubeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        cubeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        cubeView.widthAnchor.constraint(equalToConstant: 60),
        cubeView.heightAnchor.constraint(equalTo: cubeLabel.widthAnchor),
        
        cubeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        cubeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        cubeButton.widthAnchor.constraint(equalToConstant: 120),
        cubeButton.heightAnchor.constraint(equalTo: cubeButton.widthAnchor),
        
        cubeLabel.centerXAnchor.constraint(equalTo:view.centerXAnchor),
        cubeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        cubeLabel.widthAnchor.constraint(equalToConstant: 60),
        cubeLabel.heightAnchor.constraint(equalTo: cubeLabel.widthAnchor)
        
        ])
    }
    
    func rollDice() {
        let diceRoll = Int(arc4random_uniform(6) + 1)
        cubeLabel.text = String(diceRoll)
    }
}
