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
    
    case getIssues(user: String, repo: String)
    case getDetailIssue(user: String, repo: String, number: Double)
    
    var method: HTTPMethod {
        switch self {
        case .getIssues:
            return .get
        case .getDetailIssue:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getIssues(let user, let repo):
            return "/repos/\(user)/\(repo)/issues"
        case .getDetailIssue(let user, let repo, let number):
            return "/repos/\(user)/\(repo)/issues/\(number)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Endpoint.baseURLString.asURL()
        
        var parameters: [String: Any]?
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getIssues,
             .getDetailIssue:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
            break
        }
        urlRequest.setValue("token eb43d9c4bb999ad3aa3b3127c6615c241cd41ff9", forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
}
