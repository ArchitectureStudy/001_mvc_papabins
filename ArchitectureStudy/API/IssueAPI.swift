//
//  IssueAPI.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 20..
//  Copyright © 2017년 papabins. All rights reserved.
//

import Foundation
import Alamofire

class IssueAPI {
    private let user: String
    private let repo: String
    
    private let endpoint: Endpoint
    
    init(user: String, repo: String) {
        self.user = user
        self.repo = repo
        self.endpoint = .getIssues(user: user, repo: repo)
    }
    
    // MARK: - Public Methods
//    func getIssues(completion: @escaping (ApiResult<Any>) -> Void) {
//        
//        APIManager.sharedInstance.requestApi(self.endpoint).responseApi(completionHandler: response:DataResponse<Any>) {
//            switch response.result {
//            case .Success(let json):
//                completion(ApiResult{ return json })
//            case .Failure(let error):
//                completion(ApiResult{ throw error })
//            }
//    	}
//    }
}


