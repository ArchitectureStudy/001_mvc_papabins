//
//  IssueAPI.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 20..
//  Copyright © 2017년 papabins. All rights reserved.
//

import Foundation
import Alamofire

class IssueAPI: APIManager {
    private let user: String
    private let repo: String
    
    private let manager: APIManager
    private let endpoint: Endpoint
    
    init(user: String, repo: String) {
        self.user = user
        self.repo = repo
        self.manager = SessionManager.default
        self.endpoint = .getIssues(user: user, repo: repo)
    }
    
    // MARK: - Public Methods
    func getIssues(completion: @escaping (ApiResult<Any>) -> Void) {
        
        self.manager.requestApi(self.endpoint).responseApi(completionHandler: { (response: DataResponse<Any> -> Void) in
            switch response.result {
            case .Success(let json):
                completion(ApiResult{ return json })
            case .Failure(let error):
                completion(ApiResult{ throw error })
            }
        })
    }
    
//    @discardableResult
//    func issues(success: (([Issue])->Void)?, failure: ((Error)->Void)?) -> DataRequest {
//        return load(router: .issues(user: user, repo: repo), success: success, failure: failure)
//    }
//    
//    @discardableResult
//    func issue(number: Int, success: ((Issue)->Void)?, failure: ((Error)->Void)?) -> DataRequest {
//        return item(router: .issue(user: user, repo: repo, number: number), success: success, failure: failure)
//    }
//    
//    @discardableResult
//    func create(title: String, body: String, success: ((Issue)->Void)?, failure: ((Error)->Void)?) -> DataRequest? {
//        return createItem(router: .createIssue(user: user, repo: repo, parameters: [
//            "title": title,
//            "body": body
//            ]), success: success, failure: failure)
//    }
}

enum ApiResult<Value> {
    case success(value: Value)
    case failure(error: NSError)
    
    init(_ f: () throws -> Value) {
        do {
            let value = try f()
            self = .success(value: value)
        } catch let error as NSError {
            self = .failure(error: error)
        }
    }
    
    func unwrap() throws -> Value {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}
