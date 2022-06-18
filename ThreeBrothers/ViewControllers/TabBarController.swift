//
//  TabBarViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 19.05.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    typealias Dependencies = DataManagerProtocol & AuthManagerProtocol
    
    var databaseManager: DatabaseServices
    var authManager: AuthManager
    
    init(container: Dependencies) {
        self.databaseManager = container.databaseServices
        self.authManager = container.authManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainVC = UINavigationController(rootViewController: MainViewController(databaseServices: databaseManager))
        let profileVC = UINavigationController(rootViewController: ProfileViewController(databaseServices: databaseManager))
        let contactsVC = UINavigationController(rootViewController: ContactsViewController())
        let cartVC = UINavigationController(rootViewController: CartViewController(databaseServices: databaseManager))
    
        mainVC.title = "Меню"
        profileVC.title = "Профиль"
        contactsVC.title = "Котнакты"
        cartVC.title = "Корзина"
        
        self.setViewControllers([mainVC, profileVC, contactsVC, cartVC], animated: true)
        guard let items = self.tabBar.items else { return }
        
        let images = ["menucard", "person.circle", "mappin.circle", "cart"]
        for i in 0 ..< items.count {
            items[i].image = UIImage(systemName: images[i])
        }
        self.modalPresentationStyle = .fullScreen
    }
}
