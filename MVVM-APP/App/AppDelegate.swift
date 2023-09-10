//
//  AppDelegate.swift
//  MVVM-APP
//
//  Created by Искандер Ситдиков on 25.08.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigatonVC = UINavigationController(rootViewController: MainViewController())
        window.rootViewController = navigatonVC
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

