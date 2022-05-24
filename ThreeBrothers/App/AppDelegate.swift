//
//  AppDelegate.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 18.05.2022.
//

import UIKit
import Firebase
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        let window = UIWindow()
        window.rootViewController = PhoneViewController()
        
        if !UserDefaults.standard.bool(forKey: "status") {
            let navVC = UINavigationController(rootViewController: PhoneViewController()) 
            window.rootViewController = navVC
        } else {
            print(UserDefaults.standard.bool(forKey: "status"))
            window.rootViewController = TabBarController()
        }
        
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

    }
}
