//
//  AppDelegate.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 18.05.2022.
//

import UIKit
import Firebase
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let authManager = AuthManager.shared
        let databaseServices = DatabaseServices.shared
        
        let window = UIWindow()
        window.rootViewController = PhoneViewController(authManager: authManager)
        
        if Auth.auth().currentUser == nil {
            let navVC = UINavigationController(rootViewController: PhoneViewController(authManager: authManager))
            window.rootViewController = navVC
        } else {
            window.rootViewController = TabBarController(
                container: AppDependency(
                    databaseServices: databaseServices,
                    authManager: authManager))
        }
        
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

    }
}
