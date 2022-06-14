//
//  ProductsViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 12.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ProductsDisplayLogic: AnyObject {
    func displaySomething(viewModel: Products.Something.ViewModel)
}

class ProductsViewController: UIViewController {
        
    var interactor: ProductsBusinessLogic?
    var router: (NSObjectProtocol & ProductsRoutingLogic & ProductsDataPassing)?
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }
    
    // MARK: Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
        
    private func doSomething() {
        let request = Products.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = ProductsInteractor()
        let presenter = ProductsPresenter()
        let router = ProductsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension ProductsViewController: ProductsDisplayLogic {
    func displaySomething(viewModel: Products.Something.ViewModel) {
        
    }
}