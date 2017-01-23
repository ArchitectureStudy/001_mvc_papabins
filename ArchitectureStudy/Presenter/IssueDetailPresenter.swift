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
        self.dataSource = IssueDetail(user: "ArchitectureStudy", repo: "study", number: number)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updatedIssue),
                                               name: .newIssue,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updatedComments),
                                               name: .newComments,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(createdComment),
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
    
    @objc func createdComment(_ notification: Notification) {
        guard let isSuccess: Bool = notification.userInfo!["isSuccess"] as! Bool? else { return }
        self.delegate?.didCreatedComment(isSuccess: isSuccess)
    }
    
}
