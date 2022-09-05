//
//  AppDelegate.swift
//  DreamPJ_SchoolFoodGuide
//
//  Created by 이태형 on 2022/08/08.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = ViewController()
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
//        window?.backgroundColor = .systemBackground
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

