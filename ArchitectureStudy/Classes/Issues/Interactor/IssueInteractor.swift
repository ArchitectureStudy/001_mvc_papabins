//
//  IssueInteractor.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 2. 28..
//  Copyright © 2017년 papabins. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper
import Alamofire

class IssueInteractor: IssuesUseCase {
    
    weak var output: IssuesInteractorOutput!
    var user: String
    var repo: String
    var issues = [Issue]()
    
    required init(user: String, repo: String) {
        self.user = user
        self.repo = repo
    }
    
    func fetchIssues() {
        let endpoint: Endpoint = .getIssues(user: user, repo: repo)
        Alamofire.request(endpoint).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? [[String: Any]] {
                    self.issues = Mapper<Issue>().mapArray(JSONArray: json)!
                    self.output.issuesFetched(self.issues)
                }
            case .failure(let error):
                print("----- error: \(error)")
                self.output.issuesFetchFailed()
            }
        }
    }
}
