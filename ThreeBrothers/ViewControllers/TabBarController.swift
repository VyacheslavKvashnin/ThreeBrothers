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
        let profileVC = ProfileViewController()
        let contactsVC = ContactsViewController()
        let cartVC = CartViewController()
        
        mainVC.title = "Меню"
        profileVC.title = "Профиль"
        contactsVC.title = "Котнакты"
        cartVC.title = "Корзина"
        
        self.setViewControllers([mainVC, profileVC, contactsVC, cartVC], animated: true)
        self.modalPresentationStyle = .fullScreen
    }
}
