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
        if let userName = GithubInfo.sharedInstance.userName,
            let repository = GithubInfo.sharedInstance.repository {
            self.dataSource = Issues(user: userName, repo: repository)
        }
        else {
            self.dataSource = Issues(user: "", repo: "")
            assertionFailure()
        }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updatedIssues),
                                               name: .newIssues,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(createdComment(_ :)),
                                               name: .createComment,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public func loadIssues() {
        dataSource.loadIssues()
    }
    
    @objc func updatedIssues() {
        self.delegate?.didFinishLoadIssues()
    }
    
    @objc func createdComment(_ notification: NSNotification) {
        if let result = notification.userInfo?["isSuccess"] as? String {
            let isSuccess: Bool = result == "OK" ? true : false
            if isSuccess {
                // 코멘트 추가 완료되면 이슈리스트 다시 로드.
                self.loadIssues()
            }
        }
    }
    
}
