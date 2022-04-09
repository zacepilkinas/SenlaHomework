//
//  GameViewController.swift
//  4thtaskSwift
//
//  Created by Anastasia on 29.03.2022.
//

import UIKit

// как сохранить состояние кнопки??
// почему не меняется язык у тайтлов у контроллеров??
//как загрузить в гит работу?

class GameViewController: UIViewController {
    
    private var modeChange = GameMode.withTie
    
    enum Selection: Int, CaseIterable {
        case stone = 0
        case scissors = 1
        case paper = 2
    }

    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.imageView?.tintColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 70)
        button.addAction(UIAction() { [weak self] _ in
            self?.settingsButtonDidTap()
        }, for: .touchUpInside)
        return button
    }()
    
    lazy var stoneButton: UIButton = {
        let button = UIButton()
        button.tag = Selection.stone.rawValue
        button.setTitle("✊🏼", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 70)
        button.addAction(UIAction() { [weak self] _ in
            self?.gameButtonDidTap(u: .stone)
        }, for: .touchUpInside)
        button.tag = 0
        return button
    }()
    
    lazy var scissorsButton: UIButton = {
        let button = UIButton()
        button.tag = Selection.scissors.rawValue
        button.setTitle("✌🏼", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 80)
        button.addAction(UIAction() { [weak self] _ in
            self?.gameButtonDidTap(u: .scissors)
        }, for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    lazy var paperButton: UIButton = {
        let button = UIButton()
        button.tag = Selection.paper.rawValue
        button.setTitle("✋🏼", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 80)
        button.addAction(UIAction() { [weak self] _ in
            self?.gameButtonDidTap(u: .paper)
        }, for: .touchUpInside)
        button.tag = 3
        return button
    }()

    lazy var gameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.text = "Start"
        label.textAlignment = .center
        return label
    }()
    
    lazy var gameView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addSubviews()
        makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = LanguageLocalization.shared.dictionary.gameTitle
    }
}


extension GameViewController: SettingsViewControllerDelegate {
    func didChangeGameMode(gameMode: GameMode) {
        switch gameMode {
        case .withTie:
            modeChange = .withTie
        case .withOutTie:
            modeChange = .withOutTie
        }
    }
    
    func didChangeLanguage(language: Languages) {
    }
    
    func settingsButtonDidTap() {
        let controller = SettingsViewController()
        controller.settingsDelegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
}

private extension GameViewController {
    
    func setup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
        view.backgroundColor = .white
        gameView.backgroundColor = .systemPink
    }
    
    func addSubviews() {
        view.addSubview(gameView)
        view.addSubview(stoneButton)
        view.addSubview(scissorsButton)
        view.addSubview(paperButton)
        view.addSubview(gameLabel)
    }
    
    func makeConstraints() {
        stoneButton.translatesAutoresizingMaskIntoConstraints = false
        scissorsButton.translatesAutoresizingMaskIntoConstraints = false
        paperButton.translatesAutoresizingMaskIntoConstraints = false
        gameLabel.translatesAutoresizingMaskIntoConstraints = false
        gameView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stoneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stoneButton.widthAnchor.constraint(equalToConstant: 80),
            stoneButton.heightAnchor.constraint(equalTo: stoneButton.widthAnchor),
            stoneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300),
            
            
            scissorsButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 270),
            scissorsButton.widthAnchor.constraint(equalToConstant: 80),
            scissorsButton.heightAnchor.constraint(equalTo: scissorsButton.widthAnchor),
            scissorsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            
            
            paperButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 70),
            paperButton.widthAnchor.constraint(equalToConstant: 80),
            paperButton.heightAnchor.constraint(equalTo: paperButton.widthAnchor),
            paperButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            
            
            gameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            gameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameLabel.widthAnchor.constraint(equalToConstant: 300),
            gameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            gameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            gameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameView.widthAnchor.constraint(equalToConstant: 400),
            gameView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func gameButtonDidTap(u: Selection) {
        
        guard let computerChoice = Selection.allCases.randomElement() else {
            fatalError()
        }
        
        print("Computer choice: \(computerChoice), your choice: \(u)")

        switch (u, computerChoice){
            case (.stone, .stone), (.scissors, .scissors), (.paper, .paper):
                if modeChange == .withTie {
                    gameLabel.text = LanguageLocalization.shared.dictionary.tie
                }
                break
            case (.stone, .scissors), (.scissors, .paper), (.paper, .stone):
                gameLabel.text = LanguageLocalization.shared.dictionary.win
                break
            case (.paper, .scissors), (.scissors, .stone), (.stone, .paper):
                gameLabel.text = LanguageLocalization.shared.dictionary.computer
            break
        }
    }
}
