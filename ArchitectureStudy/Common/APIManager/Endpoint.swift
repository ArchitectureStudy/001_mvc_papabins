//
//  Endpoint.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 1. 13..
//  Copyright © 2017년 papabins. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoint: URLRequestConvertible {
    
    static let baseURLString = "https://api.github.com"
    static let perPage = 50
    
    case getIssue(user: String, repo: String, number: String)
    case getIssues(user: String, repo: String)
    case getComments(user: String, repo: String, number: String)
    case createComment(user: String, repo: String, number: String, body: String)
    
    var method: HTTPMethod {
        switch self {
        case .getIssue:
            return .get
        case .getIssues:
            return .get
        case .getComments:
            return .get
        case .createComment:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getIssue(let user, let repo, let number):
            return "/repos/\(user)/\(repo)/issues/\(number)"
        case .getIssues(let user, let repo):
            return "/repos/\(user)/\(repo)/issues"
        case .getComments(let user, let repo, let number):
            return "/repos/\(user)/\(repo)/issues/\(number)/comments"
        case .createComment(let user, let repo, let number, _):
            return "/repos/\(user)/\(repo)/issues/\(number)/comments"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Endpoint.baseURLString.asURL()
        
        let params: [String: Any] = ["state": "all",
                                         "page": "1",
                                         "per_page": Endpoint.perPage,
                                         "sort": "updated"]
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getIssue,
             .getIssues,
             .getComments:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        case .createComment(_, _, _, let bodyString):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["body": bodyString])
            break
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("token c5e4ec18f50bc3ff8dfe5fa61959969e92ff277f", forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
}
