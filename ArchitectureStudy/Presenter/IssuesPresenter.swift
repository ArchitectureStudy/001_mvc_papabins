//
//  IssuesPresenter.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 16..
//  Copyright © 2017년 papabins. All rights reserved.
//

import UIKit
import Foundation

protocol IssuesPresensterProtocol {
    
    func didFinishLoadIssues()
//    func error(_ message: String)
}

class IssuesPresenter {
    
    private var delegate: IssuesPresensterProtocol?
    var dataSource: Issues = Issues()
    
    required init(delegate: IssuesPresensterProtocol) {
        
        self.delegate = delegate
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updatedIssues),
                                               name: Issues.notificationOfNewIssues,
                                               object: nil)
    }
    
    public func loadIssues() {
        dataSource.loadIssues()
    }
    
    @objc func updatedIssues() {
        self.delegate?.didFinishLoadIssues()
    }
    
}
