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
    
    case getIssues(user: String, repo: String)
    case getComments(user: String, repo: String, number: String)
    
    var method: HTTPMethod {
        switch self {
        case .getIssues:
            return .get
        case .getComments:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getIssues(let user, let repo):
            return "/repos/\(user)/\(repo)/issues"
        case .getComments(let user, let repo, let number):
            return "/repos/\(user)/\(repo)/issues/\(number)/comments"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Endpoint.baseURLString.asURL()
        
        let parameters: [String: Any] = ["state": "all",
                                         "page": "1",
                                         "per_page": Endpoint.perPage,
                                         "sort": "updated"]
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getIssues,
             .getComments:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            break
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("token 6d846b7883c2b3ce96412bf2c77991989074aaee", forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
}
