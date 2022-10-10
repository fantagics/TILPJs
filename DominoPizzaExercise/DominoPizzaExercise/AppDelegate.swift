//
//  AppDelegate.swift
//  DominoPizzaExercise
//
//  Created by 이태형 on 2022/09/09.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let categoryVC = CategoryViewController()
        let firstNavVC = UINavigationController(rootViewController: categoryVC)
        let wishListVC = WishListViewController()
        let secondNavVC = UINavigationController(rootViewController: wishListVC)
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = UIColor.orange
        firstNavVC.tabBarItem = UITabBarItem(title: "Domino/'s", image: UIImage(named: "domino's"), tag: 0)
        secondNavVC.tabBarItem = UITabBarItem(title: "Wish List", image: UIImage(named: "wishlist"), tag: 1)
        tabBarController.viewControllers = [firstNavVC, secondNavVC]
        
        window?.rootViewController = tabBarController
//        window?.backgroundColor = .systemBackground
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

