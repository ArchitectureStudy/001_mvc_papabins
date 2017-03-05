//
//  LoginProtocol.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 3. 1..
//  Copyright © 2017년 papabins. All rights reserved.
//

import UIKit

protocol LoginWireframe: class {
    weak var viewController: UIViewController? { get set }
    
    func presentIssues()
    static func initialize() -> UIViewController
}

protocol LoginView: class {
    var presenter: LoginPresentation! { get set }
    
}

protocol LoginPresentation: class {
    weak var view: LoginView? { get set }
    var router: LoginWireframe! { get set }
    
    func didClickStartButton()
}
