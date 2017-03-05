//
//  IssuesProtocol.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 2. 28..
//  Copyright © 2017년 papabins. All rights reserved.
//

import UIKit

protocol IssuesView {
    var presenter: IssuesPresentation! { get set }
    
    func showIssuesData(_ issues: [Issue])
}

protocol IssuesPresentation: class {
    weak var view: IssuesView? { get set }
    var interactor: IssuesUseCase! { get set }
    var router: IssuesWireframe! { get set }
    
    func viewDidLoad()
    func didSelectIssue(_ issue: Issue)
}

protocol IssuesUseCase: class {
    weak var output: IssuesInteractorOutput! { get set }
    
    func fetchIssues()
}

protocol IssuesInteractorOutput: class {
    func issuesFetched(_ issues: [Issue])
    func issuesFetchFailed()
}

protocol IssuesWireframe: class {
    weak var viewController: UIViewController? { get set }
    
    func presentDetails(forIssue issue: Issue)
    
    static func assembleModule() -> UIViewController
}
