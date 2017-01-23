//
//  IssueDetail.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 23..
//  Copyright © 2017년 papabins. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper
import Alamofire

class IssueDetail {
    
    var user: String
    var repo: String
    var num: String
    
    var issue: Issue?
    var comments = [Comment]()
    
    required init(user: String, repo: String, number: String) {
        self.user = user
        self.repo = repo
        self.num = number
    }
    
    func loadIssue() {
        let endpoint: Endpoint = .getIssue(user: user, repo: repo, number: num)
        Alamofire.request(endpoint).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? [String: Any] {
                    self.issue = Mapper<Issue>().map(JSON: json)
                    NotificationCenter.default.post(name: .newIssue, object: nil)
                }
            case .failure(let error):
                print("----- error: \(error)")
            }
        }
    }
    
    func loadComments() {
        let endpoint: Endpoint = .getComments(user: user, repo: repo, number: num)
        Alamofire.request(endpoint).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? [[String: Any]] {
                    self.comments = Mapper<Comment>().mapArray(JSONArray: json)!
                    NotificationCenter.default.post(name: .newComments, object: nil)
                }
            case .failure(let error):
                print("----- error: \(error)")
            }
        }
    }
    
    func createComment(comment: String) {
        let endpoint: Endpoint = .createComment(user: user, repo: repo, number: num, body: comment)
        Alamofire.request(endpoint).responseJSON { response in
            switch response.result {
            case .success:
                NotificationCenter.default.post(name: .createComment, object: ["isSuccess": true])
            case .failure(let error):
                NotificationCenter.default.post(name: .createComment, object: ["isSuccess": false])
                print("----- error: \(error)")
            }
        }
    }
}


