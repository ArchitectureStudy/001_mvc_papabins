//
//  Issues.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 9..
//  Copyright © 2017년 papabins. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper
import Alamofire

class Issues {
    
    var user: String
    var repo: String
    var issues = [Issue]()
    
    required init(user: String, repo: String) {
        self.user = user
        self.repo = repo
    }
    
    func loadIssues() {
        let endpoint: Endpoint = .getIssues(user: user, repo: repo)
        Alamofire.request(endpoint).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? [[String: Any]] {
                    self.issues = Mapper<Issue>().mapArray(JSONArray: json)!
                    NotificationCenter.default.post(name: .newIssues, object: nil)
                }
            case .failure(let error):
                print("----- error: \(error)")
            }
        }
    }
}
