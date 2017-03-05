//
//  LoginRouter.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 3. 1..
//  Copyright © 2017년 papabins. All rights reserved.
//

import Foundation

import UIKit

class LoginRouter: LoginWireframe {
    
    weak var viewController: UIViewController?
    
    static func initialize() -> UIViewController {
        
        let view: LoginViewController = UIStoryboard(storyboard: .main).instantiateViewController()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        
        let navigation = UINavigationController(rootViewController: view)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        
        router.viewController = view
        
        return navigation
    }
    
    func presentIssues() {
//        let detailsModuleViewController = DetailsRouter.assembleModule(article)
//        viewController?.navigationController?.pushViewController(detailsModuleViewController, animated: true)
    }
}

