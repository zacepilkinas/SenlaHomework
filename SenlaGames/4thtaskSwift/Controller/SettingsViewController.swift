//
//  SettingsViewController.swift
//  4thtaskSwift
//
//  Created by Anastasia on 29.03.2022.
//

import UIKit


protocol SettingsViewControllerDelegate: AnyObject {
    func didChangeGameMode(gameMode: GameMode)
}


class SettingsViewController: UIViewController {
    
    enum SettingsControl: Int {
        case language
        case gameMode
    }
  
    weak var settingsDelegate: SettingsViewControllerDelegate?
    
    var backButton: UIBarButtonItem!

    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Language"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private lazy var gameModeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Mode"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private lazy var languageControl: UISegmentedControl = {
        let control = UISegmentedControl(items: Languages.allCases.map({ language in
            return language.rawValue
        }))
        control.layer.cornerRadius = 10
        control.addTarget(self, action: #selector(changeLanguage), for: .valueChanged)
        return control
    }()
    
    private lazy var gameModeControl: UISegmentedControl = {
        let control = UISegmentedControl(items:  GameMode.allCases.map({ gameMode in
            return gameMode.rawValue
        }))
        control.layer.cornerRadius = 10
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(changeGameMode), for: .valueChanged)
        control.tag = SettingsControl.gameMode.rawValue
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        addSubviews()
        makeConstraints()
//        backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward.circle"), style: .done, target: self, action: #selector(didtapButton(_:)))
//        backButton.tintColor = .systemPink
//        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func didtapButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
     }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = LanguageLocalization.shared.dictionary.settingsTitle
        switch LanguageLocalization.shared.language {
        case .english:
            languageControl.selectedSegmentIndex = 0
        case .russian:
            languageControl.selectedSegmentIndex = 1
        }
    }
}


extension SettingsViewController {
    
    func makeConstraints() {

        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        languageControl.translatesAutoresizingMaskIntoConstraints = false
        
        gameModeLabel.translatesAutoresizingMaskIntoConstraints = false
        gameModeControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            languageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            languageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            languageLabel.widthAnchor.constraint(equalToConstant: 100),
            languageLabel.heightAnchor.constraint(equalToConstant: 20),
            
            languageControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            languageControl.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 10),
            languageControl.widthAnchor.constraint(equalToConstant: 100),
            languageControl.heightAnchor.constraint(equalToConstant: 35),
            
            gameModeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            gameModeLabel.topAnchor.constraint(equalTo: languageControl.bottomAnchor, constant: 10),
            gameModeLabel.widthAnchor.constraint(equalToConstant: 100),
            gameModeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            gameModeControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            gameModeControl.topAnchor.constraint(equalTo: gameModeLabel.bottomAnchor, constant: 10),
            gameModeControl.widthAnchor.constraint(equalToConstant: 100),
            gameModeControl.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
    func setup() {
        languageControl.backgroundColor = .white
        gameModeControl.backgroundColor = .white
    }
    
    func addSubviews() {
        view.addSubview(languageLabel)
        view.addSubview(languageControl)
        view.addSubview(gameModeLabel)
        view.addSubview(gameModeControl)
    }

    @objc func changeLanguage() {
        guard let selectedTitle = languageControl.titleForSegment(at: languageControl.selectedSegmentIndex) else {return}
        guard let chosenLanguage = Languages.init(rawValue: selectedTitle) else { return }
        
        switch chosenLanguage {
        case .english:
            LanguageLocalization.shared.language = .english
        case .russian:
            LanguageLocalization.shared.language = .russian
        }
    }
    
    @objc func changeGameMode() {
        guard let selectedTitle = gameModeControl.titleForSegment(at: gameModeControl.selectedSegmentIndex) else {return}
        guard let chosenGameMode = GameMode.init(rawValue: selectedTitle) else { return }
        
        switch chosenGameMode {
        case .withTie:
            settingsDelegate?.didChangeGameMode(gameMode: .withTie)
        case .withOutTie:
            settingsDelegate?.didChangeGameMode(gameMode: .withOutTie)
        }
    }
}
