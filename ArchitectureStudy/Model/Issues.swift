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
    static let notificationOfNewIssues = NSNotification.Name(rawValue: "NewIssues")
    
    var user: String
    var repo: String
    var issues = [Issue]()
    
    required init(user: String, repo: String) {
        self.user = user
        self.repo = repo
    }
    
    func loadIssues() {
        let endpoint: String = "https://api.github.com/repos/\(user)/\(repo)/issues?state=all&page=1&per_page=100&sort=updated"
        Alamofire.request(endpoint).responseJSON { response in
            
                switch response.result {
                case .success:
                    if let json = response.result.value as? [[String: Any]] {
                        self.issues = Mapper<Issue>().mapArray(JSONArray: json)!
                        NotificationCenter.default.post(name: Issues.notificationOfNewIssues, object: nil)
                    }
                case .failure(let error):
                    print("----- error: \(error)")
                }
        }
    }
}
