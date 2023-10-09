//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Ilnur on 30.09.2023.
//

import UIKit

//MARK: - SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let characterListViewModel = CharacterListViewModel()
        let characterViewController = CharacterViewController(viewModel: characterListViewModel)
        let navigationController = UINavigationController(rootViewController: characterViewController)
        navigationController.navigationBar.tintColor = .acidColor
        navigationController.navigationBar.backgroundColor = .backgroundDarkGrayColor
        navigationController.navigationBar.barTintColor = .backgroundGrayColor
        
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}
