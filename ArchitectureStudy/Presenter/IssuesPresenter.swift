//
//  IssuesPresenter.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 16..
//  Copyright © 2017년 papabins. All rights reserved.
//

import Foundation

protocol IssuesPresensterProtocol {
    
    func didFinishLoadIssues()
}

class IssuesPresenter {
    
    private var delegate: IssuesPresensterProtocol?
    var dataSource: Issues
    
    required init(delegate: IssuesPresensterProtocol) {
        
        self.delegate = delegate
        self.dataSource = Issues(user: "ArchitectureStudy", repo: "study")
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
