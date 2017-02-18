//
//  IssueDetailPresenter.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 23..
//  Copyright © 2017년 papabins. All rights reserved.
//

import Foundation

protocol IssueDetailPresenterDelegate {
    func didFinishLoadIssue()
    func didFinishLoadComments()
    func didCreatedComment(isSuccess: Bool)
}

class IssueDetailPresenter {
    
    private var delegate: IssueDetailPresenterDelegate?
    var dataSource: IssueDetail
    
    required init(delegate: IssueDetailPresenterDelegate, number: String) {
        
        self.delegate = delegate
        if let userName = GithubInfo.sharedInstance.userName,
            let repository = GithubInfo.sharedInstance.repository {
            self.dataSource = IssueDetail(user: userName, repo: repository, number: number)
        }
        else {
            self.dataSource = IssueDetail(user: "", repo: "", number: number)
            assertionFailure()
        }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updatedIssue),
                                               name: .newIssue,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updatedComments),
                                               name: .newComments,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(createdComment(_ :)),
                                               name: .createComment,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public func loadIssue() {
        dataSource.loadIssue()
    }
    
    public func loadComments() {
        dataSource.loadComments()
    }
    
    public func createComments(comment: String) {
        dataSource.createComment(comment: comment)
    }
    
    @objc func updatedIssue() {
        self.delegate?.didFinishLoadIssue()
    }
    
    @objc func updatedComments() {
        self.delegate?.didFinishLoadComments()
    }
    
    @objc func createdComment(_ notification: NSNotification) {
        if let result = notification.userInfo?["isSuccess"] as? String {
            let isSuccess: Bool = result == "OK" ? true : false
            if isSuccess {
                // 코멘트 추가 완료되면 코멘트를 다시 로드.
                self.loadComments()
            }
            self.delegate?.didCreatedComment(isSuccess: isSuccess)
        }
        else {
            self.delegate?.didCreatedComment(isSuccess: false)
        }
    }
    
}
