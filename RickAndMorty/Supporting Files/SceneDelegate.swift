//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Ilnur on 30.09.2023.
//

import UIKit

//MARK: - TabBarItemConstants
private enum TabBarItemConstants: String {
    case charactersTitle = "Characters"
    case favoritesTitle = "Favorites"
    
    case charactersImage = "person.3.fill"
    case favoritesImage = "star.fill"
}

//MARK: - SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let tabBarController = createTabBarController()
        
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }
}

//MARK: - Private methods
private extension SceneDelegate {
    
    //MARK: - CreateUI
    func createTabBarController() -> UITabBarController {
        
        let tabBarController: UITabBarController = {
            let tabBarController = UITabBarController()
            tabBarController.tabBar.isTranslucent = true
            tabBarController.tabBar.barStyle = .default
            tabBarController.tabBar.barTintColor = .backgroundDarkGrayColor
            tabBarController.tabBar.backgroundColor = .backgroundGrayColor
            tabBarController.viewControllers = createViewControllers()
            tabBarController.tabBar.tintColor = .acidColor
            tabBarController.tabBar.unselectedItemTintColor = .indicatorGrayColor
            return tabBarController
        }()
        
        return tabBarController
    }
    
    func createViewControllers() -> [UIViewController] {
        
        let charactersViewController: CharacterViewController = {
            let charactersViewController = CharacterViewController()
            charactersViewController.title = TabBarItemConstants.charactersTitle.rawValue
            charactersViewController.tabBarItem = UITabBarItem(title: TabBarItemConstants.charactersTitle.rawValue,
                                                               image: UIImage(systemName: TabBarItemConstants.charactersImage.rawValue),
                                                               tag: 0)
            return charactersViewController
        }()
        
        let navigationController: UINavigationController = {
            let navigationController = UINavigationController(rootViewController: charactersViewController)
            navigationController.navigationBar.barTintColor = .backgroundDarkGrayColor
            navigationController.navigationBar.tintColor = .acid
            return navigationController
        }()
        
        let favoritesViewController: FavoritesListViewController = {
            let favoritesViewController = FavoritesListViewController()
            favoritesViewController.title = TabBarItemConstants.favoritesTitle.rawValue
            favoritesViewController.tabBarItem = UITabBarItem(title: TabBarItemConstants.favoritesTitle.rawValue,
                                                              image: UIImage(systemName: TabBarItemConstants.favoritesImage.rawValue),
                                                              tag: 1)
            return favoritesViewController
        }()
        
        return [navigationController, favoritesViewController]
    }
}
