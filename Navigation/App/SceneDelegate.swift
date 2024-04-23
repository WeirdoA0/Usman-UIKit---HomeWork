//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Руслан Усманов on 13.09.2023.
//

import UIKit
import StorageService
import NetworkService
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?



    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
//        let appConfiguarion: AppConfiguration = AppConfiguration.allCases.randomElement()!
//        let url = appConfiguarion.url
//        NetworkService.request(url: url!)



        let logInViewController = LogInViewController()
        let feedViewController = FeedViewController()
        let favoritesVC = FavoritesViewController()
        
        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = [feedViewController,logInViewController, favoritesVC].map {
            UINavigationController(rootViewController: $0)
        }
        
        logInViewController.tabBarItem = UITabBarItem(title: "Profile".localizeed(), image: resizeImage(image: UIImage(named: "profile")!, targetSize: CGSize(width: 30, height: 30)), tag: 1)
        feedViewController.tabBarItem = UITabBarItem(title: "Feed".localizeed(), image: resizeImage(image: UIImage(named: "feed")!, targetSize: CGSize(width: 30, height: 30)), tag: 0)
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        logInViewController.loginDelegate = MyLoginFactory().makeLoginInspector()
        
        
        tabBarController.selectedIndex = 1
        
        tabBarController.tabBar.backgroundColor = .white
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    
    

    func sceneDidDisconnect(_ scene: UIScene) {
        try? Auth.auth().signOut()
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
}

