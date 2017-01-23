//
//  Comments.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 23..
//  Copyright © 2017년 papabins. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper
import Alamofire

class Comments {
    
    var user: String
    var repo: String
    var num: String
    var comments = [Comment]()
    
    required init(user: String, repo: String, number: String) {
        self.user = user
        self.repo = repo
        self.num = number
    }
    
    func loadIssues() {
        let endpoint: Endpoint = .getComments(user: user, repo: repo, number: num)
        Alamofire.request(endpoint).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? [[String: Any]] {
                    self.comments = Mapper<Comment>().mapArray(JSONArray: json)!
                    NotificationCenter.default.post(name: .getComments, object: nil)
                }
            case .failure(let error):
                print("----- error: \(error)")
            }
        }
    }
}

