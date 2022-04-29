//
//  TabBarController.swift
//  4thtaskSwift
//
//  Created by Anastasia on 29.03.2022.
//

import UIKit

class TabBarController: UITabBarController {

    convenience init() {
        self.init(nibName: nil, bundle: nil)
       
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .systemPink
    }
}


private extension TabBarController {
    
    func setupTabBar() {
        let historyController = HistoryViewController()
        let gameController = GameViewController()
        let rolldiceController = CubeViewController()
        
        gameController.gameDelegate = historyController
        rolldiceController.cubeDelegate = historyController
        
        let game = NavigationController(rootViewController: gameController)
        let rollDice = NavigationController(rootViewController: rolldiceController)
        let history = NavigationController(rootViewController: historyController)
        
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        
        game.tabBarItem = UITabBarItem(
            title: "Game",
            image: UIImage(systemName: "gamecontroller", withConfiguration: configuration),
            tag: 1
        )
        
        game.tabBarItem.selectedImage = UIImage(systemName: "gamecontroller.fill", withConfiguration: configuration)
        
        
        rollDice.tabBarItem = UITabBarItem(
            title: "Rolling dice",
            image: UIImage(systemName: "cube", withConfiguration: configuration),
            tag: 2
            )
        
        rollDice.tabBarItem.selectedImage = UIImage(systemName: "cube.fill", withConfiguration: configuration)
        
        history.tabBarItem = UITabBarItem(
            title: "History",
            image: UIImage(systemName: "menucard", withConfiguration: configuration),
            tag: 3
            )
        
        history.tabBarItem.selectedImage = UIImage(systemName: "menucard.fill", withConfiguration: configuration)
        
        setViewControllers([game, rollDice, history], animated: false)
        
    }
    
    
}
