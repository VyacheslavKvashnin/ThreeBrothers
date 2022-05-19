//
//  TabBarViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 19.05.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainVC = MainViewController()
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        let contactsVC = UINavigationController(rootViewController: ContactsViewController())
        let cartVC = UINavigationController(rootViewController: CartViewController())
        
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
// col
