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
        let game = NavigationController(rootViewController: GameViewController())
        let rollDice = NavigationController(rootViewController: CubeViewController())
        
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
        
        
        setViewControllers([game, rollDice], animated: false)
        
    }
}
